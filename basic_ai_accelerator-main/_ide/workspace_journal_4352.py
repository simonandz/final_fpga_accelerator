# 2025-01-11T22:22:15.811047
import vitis

client = vitis.create_client()
client.set_workspace(path="simon")

comp = client.clone_component(name="asic_accelerator",new_name="experimental_accelerator")

comp = client.get_component(name="experimental_accelerator")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp = client.clone_component(name="experimental_accelerator",new_name="ultra_experimental_accelerator")

comp = client.get_component(name="ultra_experimental_accelerator")
comp.run(operation="C_SIMULATION")

vitis.dispose()

