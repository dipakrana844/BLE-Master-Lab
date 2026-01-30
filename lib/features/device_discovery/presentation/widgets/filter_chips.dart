import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/device_discovery_provider.dart';
import '../../domain/entities/device.dart';

/// A reusable widget for displaying filter chips
class FilterChips extends ConsumerWidget {
  const FilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(
      deviceDiscoveryUiStateProvider.select((state) => state.activeFilter),
    );
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: DeviceFilter.values.map((filter) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _buildFilterChip(context, ref, filter, activeFilter),
          );
        }).toList(),
      ),
    );
  }

  /// Build individual filter chip
  Widget _buildFilterChip(
    BuildContext context,
    WidgetRef ref,
    DeviceFilter filter,
    DeviceFilter activeFilter,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isActive = filter == activeFilter;
    
    return GestureDetector(
      onTap: () => ref.read(deviceDiscoveryUiStateProvider.notifier).setActiveFilter(filter),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 36,
        decoration: BoxDecoration(
          color: isActive
              ? theme.colorScheme.primary
              : (isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive
                ? theme.colorScheme.primary
                : (isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1)),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              filter.displayName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? theme.colorScheme.onPrimary
                    : (isDark ? const Color(0xFFE2E8F0) : const Color(0xFF475569)),
              ),
            ),
            if (filter == DeviceFilter.all) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.expand_more,
                size: 18,
                color: isActive
                    ? theme.colorScheme.onPrimary
                    : (isDark ? const Color(0xFFE2E8F0) : const Color(0xFF475569)),
              ),
            ],
            if (filter == DeviceFilter.strongSignal) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.filter_list,
                size: 18,
                color: isActive
                    ? theme.colorScheme.onPrimary
                    : (isDark ? const Color(0xFFE2E8F0) : const Color(0xFF475569)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A reusable widget for search input field
class SearchField extends ConsumerWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(
      deviceDiscoveryUiStateProvider.select((state) => state.searchQuery),
    );
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: (value) => 
            ref.read(deviceDiscoveryUiStateProvider.notifier).updateSearchQuery(value),
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        decoration: InputDecoration(
          hintText: 'Search devices...',
          hintStyle: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
          ),
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                  ),
                  onPressed: () => 
                      ref.read(deviceDiscoveryUiStateProvider.notifier).updateSearchQuery(''),
                )
              : null,
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF1E293B)
              : const Color(0xFFF8FAFC),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF334155)
                  : const Color(0xFFE2E8F0),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF334155)
                  : const Color(0xFFE2E8F0),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}