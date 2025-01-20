# 2025-01-10T22:06:31.687126200
import vitis

client = vitis.create_client()
client.set_workspace(path="simon")

comp = client.create_hls_component(name = "asic_accelerator",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="asic_accelerator")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

vitis.dispose()

vitis.dispose()

