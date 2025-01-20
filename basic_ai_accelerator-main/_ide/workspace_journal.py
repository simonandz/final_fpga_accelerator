# 2025-01-14T20:21:46.118878600
import vitis

client = vitis.create_client()
client.set_workspace(path="simon")

comp = client.clone_component(name="ultra_experimental_accelerator",new_name="all_in_one")

comp = client.get_component(name="all_in_one")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

client.delete_component(name="asic_accelerator")

client.delete_component(name="experimental_accelerator")

client.delete_component(name="experimental_accelerator")

client.delete_component(name="ultra_experimental_accelerator")

client.delete_component(name="all_in_one")

vitis.dispose()

vitis.dispose()

