{% set os_family = pillar['sample_data']['family'] %}
{% set os_arch = pillar['sample_data']['architecture'] %}
{% set minion_id = pillar['sample_data']['name'] %}
{% set os_name = pillar['sample_data']['os'] %}

# Print the values of the grains
print_os_family:
  cmd.run:
    - name: "echo '{{ os_family }}: {{ salt['grains.get'](os_family) }}'"
print_os_arch:
  cmd.run:
    - name: "echo '{{ os_arch }}: {{ salt['grains.get'](os_arch) }}'"
print_minion_id:
  cmd.run:
    - name: "echo '{{ minion_id }}: {{ salt['grains.get'](minion_id) }}'"
print_os_name:
  cmd.run:
    - name: "echo '{{ os_name }}: {{ salt['grains.get'](os_name) }}'"
