Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA10380FF9
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781892462; cv=pass; b=ExRyM6fKw6rIrlPBYI6dlcZanXWp7hvQPIdiGhHebzUHQmLeCETwPqJLqCcXQ8eZqXCRPMq79LVlgDaX0XYM+zs2E4ZAmyQpSbTqqVLQiHSsSQ5gZs+T0sxsM2zzWAtggkuqdA34gZXZazIsl9dZ3NrrYpvLy7HCPrER2AN2HYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781892462; c=relaxed/simple;
	bh=7tP+BQTOdxUC2Nu9253V2DCS0VfJ0RFfOERSU3J2f28=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZRblQ04PVqRVlv9N/8czFVe7L2yJfsSHtWKQBaDoOnyCfNNDx394/lifKnu+80AkdgYaIaQmSOgCdYfCpqwHwu0BuaJ1V1+8OfBblhvfRwk9PT+fk2/MN854/MaedmZRaB3pgDmr1ikGQyA08eWlA7+i76wvB2Tpus9TczL9uQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmjtzwIY; arc=pass smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmjtzwIY"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-6974f511dd3so1470894a12.1
        for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 11:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781892459; cv=none;
        d=google.com; s=arc-20240605;
        b=FWxQgYIjtLZWFg3g0S8PAeVmEMa/toTiJ4Luz7JlIUvZ2hAX5ym9VjqMEEJ/STBRkD
         fXHcAQVJdZp6UXfVATWtGwCEUcI/hgbzVMQ7QCWNw4nVp6enmF8Iu9oMKBYBoIchEErL
         KcNJiQoxuXHKvc0KZNILZ05aWdJp4Bjzo7kMBOYw/z0KjMBDM0UUADTPYfGm6d7vGy3T
         c28OMWO3ep5NfyK2F5UQo1K7YKPUogwKFvrzX2nLWoPJPQHayz5kvcYhbcAGQlcX72KS
         UpzoU1jHLOXnsgamW/mnE7to1YcnYMUdNWtovvha99y8i+X7k5HcZV9bChZ2AOWVSZmg
         8n9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=n/Kvpf4O4zTnV+BxarCOsshHR3lFEZSn38LyVAsVRTs=;
        fh=9ua4QFfN7uJVgVXldNe/o3r3mU7ct1EGbrVXqHfT0/Y=;
        b=N5/eHjAxHQZKU7tULE38TgIdejWH2NHahjp1HvYaDv5xyqx2SOg7CM6L24eVG1DI6T
         q6KW4+WwCeNMLwyqRFtXfNq1rv/IeDkmHLyTGQEErpJxa+B0THAjpX9ygDkaRd62y/p/
         RqXS6Z7fmNqLeOkCO4Yl/8c7ItAnEXIxGRQXC+Gb9cXeHF6vAcPJ9Usvw/yfUdHXMB8I
         uv6770XxVUNSx7KJcdZLD9ZsWNPXZP8ORRq7N8/aTGzeDjYXjgoifCrC5WvF2XQxDnjr
         I0LRa2EbU8gcK5mGk1PTPHmY9NL5SmHibflQVLO6AYABwXajp5BzBTYzwlkvPW1Q33tg
         6RkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781892459; x=1782497259; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n/Kvpf4O4zTnV+BxarCOsshHR3lFEZSn38LyVAsVRTs=;
        b=XmjtzwIYO1+qlMHTvA0rt59anaYcIrZi+zbLUgp9Vqgh+GgoI7Fku7I0Lg46TuP5fG
         i5onKQld9W8mz4CG3oytpfjj7L6MQGDzXp3nN/Tw14smmxwpx+RWJB5Ru6iaRGj6Mxsb
         Rg097lvtQFurcHiRTI2DWLlKE8wweXpS5YmWYqglboXNxB52Tt86cqZQ1gt/PPZFXGzS
         2laVfEdEB9djlrMdd/XSzDPyUtxF+COlHDWK8CKbfnr821/3r8ePZDxTukWtEcp792ox
         G34vZj3Epcm4x0zgCP0Mu34SRdA7m87jDOqzo2oNYbwF1KxBsEscuU6pnokmCdTbIZnZ
         Lekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781892459; x=1782497259;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/Kvpf4O4zTnV+BxarCOsshHR3lFEZSn38LyVAsVRTs=;
        b=cV2yul65m6nQlGMbJwn/9ctWHXuNwsP/ygXKLIb81JtMj1NdVYkkk/8yBYYRGosfTp
         f8zMmQEgYzAh8tMrZy4ZCrV8t7o3UeKsIXKsMpCiTzuIU0jpwtoz3aVYEH8xsxkGwtQ/
         aso4SYJ+w2AbQZz82ar23KA3S7SUY1eS/VI7p0uNZk7POh1bgZZfQZa1eHoo/EqTYsKi
         vFG2AOFEGiVWmijcmDs7He7nQIn0G+xYZ1n+qgHUE+w7L5+7kSz5KIh14HcFxea4/YDB
         rGzs+e/oZKW7WGGMbR3mWemfk8H+ceR2GVeLCHkQPGZBm/hzg+arHSn8ZcCs0mncEMmD
         lGOw==
X-Forwarded-Encrypted: i=1; AFNElJ/9kYnD2AVecGR/pPgAqOIWH6h0SwK2bpBCHBwOMorrYWPQxtQQCzABfqTRbQJbQ3fwVa4EDM7hSnhYtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZkpLeOHly50E4znm6UCKbca/vNOcMkUQicLiwaJovCLZNsc4
	+ysGmuGHolj2EXW19SxcbzMlFLgzfW6yUaoFkfTNCO0Oy0S5cugbTtRBS4ocVs+Nat6YbAYtuGA
	jD3bmV3DIuzQP6aE9YPLzLGefmFFFpuRKFq/4SO8=
X-Gm-Gg: AfdE7clFdlzr9EyQXEPznNGmhqHWvCVT51PjHhPEdAPKvUjujgwMYKfwP1pHWEJ2IcS
	KWDsysEfA+CP5JLgEjTOIqn+Kpq0d0w3Nv1A9pLsh2IUQF9P1tlrdKAFxt66YbZcZ+ApcqTcPMP
	/OX2ZK4xWtGzkD0RkaHm4suog/Nu4N1A7/dhjWbdTGLCB3PIdyR6xIEbGBJE3x0eh4lXUbVrMPY
	IdvaU70dbHvP4xyCgITD3OpGLqTtZXEdVkIn5ojSik4HeH3XF3spw2gEbrrRoltl/B6BM4nCfut
	RoG8zw==
X-Received: by 2002:a17:907:2681:b0:beb:b53d:4841 with SMTP id
 a640c23a62f3a-c097cacb731mr266764366b.35.1781892458655; Fri, 19 Jun 2026
 11:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric LIn <ericlin200509@gmail.com>
Date: Sat, 20 Jun 2026 02:07:42 +0800
X-Gm-Features: AVVi8CfGuyQTsdjuxltSEjFpG10JqkaHHY5eZxW2gewMVMHrR-6d7pXvBVceCoc
Message-ID: <CAN+cGS7xoNnar0bUdtca05Q7iYfUeJDhOJC4CtycHVqtV+F5=A@mail.gmail.com>
Subject: [BUG] Get Kernel OOPS when detaching the stylus from laptop
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel maintainers:

I got a BUG after I upgrade the kernel to 7.1, when I detached the
stylus from my laptop, I got these kernel OOPS

```
[   67.724440] BUG: unable to handle page fault for address: ffffffffffffffe4
[   67.724455] #PF: supervisor read access in kernel mode
[   67.724459] #PF: error_code(0x0000) - not-present page
[   67.724463] PGD 642815067 P4D 642815067 PUD 642817067 PMD 0
[   67.724471] Oops: Oops: 0000 [#1] SMP NOPTI
[   67.724477] CPU: 2 UID: 0 PID: 574 Comm: irq/108-CUST000 Not
tainted 7.1.0-2-cachyos #1 PREEMPT(full)
aa2fc21b834663bf803613ae89f5425cc0ec2a9b
[   67.724485] Hardware name: Micro-Star International Co., Ltd.
Prestige 16 Flip AI+ C3MTG/MS-2622, BIOS E2622IMS.117 04/27/2026
[   67.724488] RIP: 0010:hidinput_hid_event+0x5c/0x750
[   67.724501] Code: 4c 8b 76 68 41 83 f8 16 75 73 41 8b 76 30 8b 02
48 81 c7 20 1c 00 00 48 89 fb 0f 1f 40 00 48 8b 1b 48 39 fb 0f 84 af
06 00 00 <39> 73 e4 75 ef 48 83 fb 38 0f 84 a0 06 00 00 3d 44 00 85 00
0f 85
[   67.724505] RSP: 0018:ffffd28ac1283cc8 EFLAGS: 00010203
[   67.724509] RAX: 00000000000d003b RBX: 0000000000000000 RCX: 0000000000000000
[   67.724512] RDX: ffff8d73c83d7e88 RSI: 0000000000000007 RDI: ffff8d73c6415c20
[   67.724514] RBP: 0000000000000000 R08: 0000000000000016 R09: 0000000000000003
[   67.724516] R10: 0000000000000000 R11: ffffffffc070a6c0 R12: 0000000000000001
[   67.724518] R13: ffffffffc08c70d0 R14: ffff8d73c5bb4000 R15: ffff8d73c83d7e00
[   67.724521] FS:  0000000000000000(0000) GS:ffff8d7b7f6fb000(0000)
knlGS:0000000000000000
[   67.724525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   67.724527] CR2: ffffffffffffffe4 CR3: 0000000642812005 CR4: 0000000108f72ef0
[   67.724531] PKRU: 55555554
[   67.724532] Call Trace:
[   67.724538]  <TASK>
[   67.724550]  hid_process_event+0x10e/0x160
[   67.724558]  hid_report_raw_event+0x763/0xac0
[   67.724565]  __hid_input_report.llvm.4774680079643314489+0x219/0x290
[   67.724571]  ? __pfx_irq_thread_fn+0x10/0x10
[   67.724578]  hid_safe_input_report+0x14/0x20
[   67.724587]  i2c_hid_irq+0x137/0x1c0 [i2c_hid
93a6a330bc5a69c91125ab6f51a82509be2e9c49]
[   67.724598]  irq_thread_fn+0x24/0x50
[   67.724603]  irq_thread+0x190/0x2a0
[   67.724606]  ? __pfx_irq_thread_dtor+0x10/0x10
[   67.724609]  ? __pfx_irq_thread+0x10/0x10
[   67.724612]  kthread+0xfb/0x120
[   67.724619]  ? __pfx_kthread+0x10/0x10
[   67.724622]  ret_from_fork+0xee/0x260
[   67.724628]  ? __pfx_kthread+0x10/0x10
[   67.724631]  ret_from_fork_asm+0x1a/0x30
[   67.724641]  </TASK>
[   67.724642] Modules linked in: snd_seq_dummy rfcomm snd_hrtimer
snd_seq snd_seq_device ccm algif_aead des_generic libdes md4
nft_reject_inet nf_reject_ipv6 nf_reject_ipv4 nft_reject nft_limit
nft_ct nf_conntrack uhid nf_defrag_ipv6 nf_defrag_ipv4 algif_hash
algif_skcipher af_alg nf_tables bnep nfnetlink snd_ctl_led
snd_soc_sof_sdw snd_sof_probes snd_soc_intel_hda_dsp_common f2fs vfat
lz4hc_compress fat lz4_compress snd_soc_rt1320_sdw snd_soc_rt712_sdca
snd_hda_codec_intelhdmi regmap_sdw_mbq snd_hda_codec_hdmi regmap_sdw
snd_soc_dmic snd_hda_intel snd_sof_pci_intel_ptl snd_sof_pci_intel_lnl
snd_sof_pci_intel_mtl snd_sof_intel_hda_generic soundwire_intel
soundwire_cadence snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common
snd_soc_hdac_hda snd_sof_intel_hda snd_sof_intel_hda_mlink snd_sof_pci
snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_hda_ext_core
intel_rapl_msr intel_uncore_frequency snd_hda_codec
intel_uncore_frequency_common snd_hda_core intel_tcc_cooling
snd_soc_acpi_intel_match x86_pkg_temp_thermal
[   67.724717]  snd_soc_acpi_intel_sdca_quirks snd_intel_dspcfg
intel_powerclamp snd_intel_sdw_acpi soundwire_generic_allocation
coretemp snd_soc_sdw_utils snd_soc_acpi iwlmld snd_hwdep kvm_intel
soundwire_bus mac80211 snd_soc_sdca kvm uvcvideo snd_soc_core ptp
processor_thermal_device_pci uvc ac97_bus processor_thermal_device
pps_core videobuf2_vmalloc snd_pcm_dmaengine
processor_thermal_power_floor snd_compress libarc4
processor_thermal_wt_hint videobuf2_memops spi_nor irqbypass
hid_sensor_custom_intel_hinge snd_pcm iTCO_wdt hid_sensor_als
hid_sensor_accel_3d hid_sensor_incl_3d hid_sensor_prox
hid_sensor_gyro_3d videobuf2_v4l2 hid_sensor_magn_3d
hid_sensor_rotation processor_thermal_wt_req intel_cstate mtd
intel_pmc_bxt mei_gsc_proxy snd_timer processor_thermal_rfim
hid_sensor_trigger videobuf2_common iwlwifi intel_uncore snd kfifo_buf
processor_thermal_mbox videodev btintel_pcie i2c_i801
hid_sensor_iio_common intel_pmc_core platform_temperature_control
soundcore spi_intel_pci i2c_smbus btintel pcspkr mc wmi_bmof
[   67.724792]  dptf_power msi_wmi int3403_thermal msi_wmi_platform
spi_intel crc8 i2c_mux industrialio intel_hid pmt_telemetry
processor_thermal_rapl int3400_thermal soc_button_array cfg80211
acpi_tad bluetooth sparse_keymap acpi_thermal_rel intel_rapl_common
acpi_pad mei_me processor_thermal_soc_slider pmt_discovery
intel_pmc_ssram_telemetry pmt_class rfkill mei intel_vpu igen6_edac
int340x_thermal_zone joydev mousedev mac_hid sch_fq_codel dm_crypt
encrypted_keys trusted tee asn1_encoder hid_sensor_custom
intel_ishtp_hid xe ucsi_acpi drm_gpuvm typec_ucsi drm_gpusvm_helper
roles drm_buddy gpu_sched hid_multitouch aesni_intel typec nvme
drm_suballoc_helper drm_exec gf128mul nvme_core drm_display_helper
hid_sensor_hub nvme_keyring aead cec video nvme_auth i2c_hid_acpi
i2c_algo_bit intel_lpss_pci i2c_hid wmi intel_ish_ipc drm_ttm_helper
intel_lpss thunderbolt pinctrl_intel_platform ttm idma64 intel_vsec
intel_ishtp serio_raw msi_ec dm_mirror dm_region_hash dm_log dm_mod
i2c_dev ec_sys crypto_user pkcs8_key_parser
[   67.724882] CR2: ffffffffffffffe4
[   67.724886] ---[ end trace 0000000000000000 ]---
[   67.724890] RIP: 0010:hidinput_hid_event+0x5c/0x750
[   67.724896] Code: 4c 8b 76 68 41 83 f8 16 75 73 41 8b 76 30 8b 02
48 81 c7 20 1c 00 00 48 89 fb 0f 1f 40 00 48 8b 1b 48 39 fb 0f 84 af
06 00 00 <39> 73 e4 75 ef 48 83 fb 38 0f 84 a0 06 00 00 3d 44 00 85 00
0f 85
[   67.724899] RSP: 0018:ffffd28ac1283cc8 EFLAGS: 00010203
[   67.724902] RAX: 00000000000d003b RBX: 0000000000000000 RCX: 0000000000000000
[   67.724904] RDX: ffff8d73c83d7e88 RSI: 0000000000000007 RDI: ffff8d73c6415c20
[   67.724906] RBP: 0000000000000000 R08: 0000000000000016 R09: 0000000000000003
[   67.724908] R10: 0000000000000000 R11: ffffffffc070a6c0 R12: 0000000000000001
[   67.724909] R13: ffffffffc08c70d0 R14: ffff8d73c5bb4000 R15: ffff8d73c83d7e00
[   67.724911] FS:  0000000000000000(0000) GS:ffff8d7b7f6fb000(0000)
knlGS:0000000000000000
[   67.724913] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   67.724916] CR2: ffffffffffffffe4 CR3: 0000000642812005 CR4: 0000000108f72ef0
[   67.724918] PKRU: 55555554
[   67.724920] note: irq/108-CUST000[574] exited with irqs disabled
[   67.724937] Missing ENDBR: exit_shm+0x2c/0x200
[   67.724946] ------------[ cut here ]------------
[   67.724948] kernel BUG at arch/x86/kernel/cet.c:133!
[   67.724953] Oops: invalid opcode: 0000 [#2] SMP NOPTI
[   67.724958] CPU: 2 UID: 0 PID: 574 Comm: irq/108-CUST000 Tainted: G
     D             7.1.0-2-cachyos #1 PREEMPT(full)
aa2fc21b834663bf803613ae89f5425cc0ec2a9b
[   67.724963] Tainted: [D]=DIE
[   67.724965] Hardware name: Micro-Star International Co., Ltd.
Prestige 16 Flip AI+ C3MTG/MS-2622, BIOS E2622IMS.117 04/27/2026
[   67.724967] RIP: 0010:do_kernel_cp_fault+0xd7/0xe0
[   67.724972] Code: 06 48 0f 43 ca 48 8d 0c 89 48 8d 14 4d 40 54 71
9e 48 89 c6 67 48 0f b9 3a 5b c3 cc cc cc cc cc 48 c7 43 50 00 00 00
00 eb 9c <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90
90 90
[   67.724974] RSP: 0018:ffffd28ac1283d58 EFLAGS: 00010097
[   67.724977] RAX: 0000000000000022 RBX: ffffd28ac1283d88 RCX: 5455e76f979d9500
[   67.724979] RDX: 3fffffffffffefff RSI: 0000000000000002 RDI: ffff8d7b1f69d488
[   67.724981] RBP: 0000000000000000 R08: 0000000000000fff R09: ffffffff9f25ca50
[   67.724983] R10: 0000000000002ffd R11: 0000000000000000 R12: 0000000000000000
[   67.724985] R13: 0000000000000000 R14: 0000000000000003 R15: 0000000000000000
[   67.724987] FS:  0000000000000000(0000) GS:ffff8d7b7f6fb000(0000)
knlGS:0000000000000000
[   67.724989] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   67.724990] CR2: ffffffffffffffe4 CR3: 0000000642812005 CR4: 0000000108f72ef0
[   67.724992] PKRU: 55555554
[   67.724994] Call Trace:
[   67.724996]  <TASK>
[   67.724997]  exc_control_protection+0x40/0x60
[   67.725006]  asm_fred_entrypoint_kernel+0x41/0x60
[   67.725011] RIP: 0010:exit_shm+0x2c/0x200
[   67.725014] Code: 40 d6 0f 1f 44 00 00 55 41 57 41 56 41 55 41 54
53 49 89 fe 48 8d 9f 60 0e 00 00 48 8d af 68 0d 00 00 48 89 df e8 f4
06 ad 00 <4d> 8b b6 68 0d 00 00 eb 34 66 66 2e 0f 1f 84 00 00 00 00 00
4c 89
[   67.725016] RSP: 0018:ffffd28ac1283ea8 EFLAGS: 00010286
[   67.725018] RAX: 0000000000000000 RBX: ffff8d73e95345e4 RCX: 0000000000000001
[   67.725020] RDX: ffffd28ac1283e90 RSI: 0000000000000282 RDI: ffffd28ac1283e98
[   67.725022] RBP: 0000000000000001 R08: 0000000000000fff R09: ffffffff9f25ca50
[   67.725023] R10: 0000000000002ffd R11: ffffffff9d48f3fc R12: 0000000000000000
[   67.725025] R13: ffff8d73e95345e0 R14: ffff8d73e9533780 R15: ffffffffa0030a00
[   67.725028]  ? exit_shm+0x2c/0x200
[   67.725033]  ? complete+0x1f/0x90
[   67.725038]  ? exit_shm+0x2c/0x200
[   67.725041]  ? task_work_run+0x9d/0xc0
[   67.725046]  do_exit+0x34f/0xa80
[   67.725052]  make_task_dead+0x80/0x150
[   67.725056]  rewind_stack_and_make_dead+0x16/0x20
[   67.725061] RIP: 0000:0x0
[   67.725162] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   67.725164] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX:
0000000000000000
[   67.725169] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   67.725171] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   67.725173] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   67.725175] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   67.725177] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   67.725181]  </TASK>
[   67.725183] Modules linked in: snd_seq_dummy rfcomm snd_hrtimer
snd_seq snd_seq_device ccm algif_aead des_generic libdes md4
nft_reject_inet nf_reject_ipv6 nf_reject_ipv4 nft_reject nft_limit
nft_ct nf_conntrack uhid nf_defrag_ipv6 nf_defrag_ipv4 algif_hash
algif_skcipher af_alg nf_tables bnep nfnetlink snd_ctl_led
snd_soc_sof_sdw snd_sof_probes snd_soc_intel_hda_dsp_common f2fs vfat
lz4hc_compress fat lz4_compress snd_soc_rt1320_sdw snd_soc_rt712_sdca
snd_hda_codec_intelhdmi regmap_sdw_mbq snd_hda_codec_hdmi regmap_sdw
snd_soc_dmic snd_hda_intel snd_sof_pci_intel_ptl snd_sof_pci_intel_lnl
snd_sof_pci_intel_mtl snd_sof_intel_hda_generic soundwire_intel
soundwire_cadence snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common
snd_soc_hdac_hda snd_sof_intel_hda snd_sof_intel_hda_mlink snd_sof_pci
snd_sof_xtensa_dsp snd_sof snd_sof_utils snd_hda_ext_core
intel_rapl_msr intel_uncore_frequency snd_hda_codec
intel_uncore_frequency_common snd_hda_core intel_tcc_cooling
snd_soc_acpi_intel_match x86_pkg_temp_thermal
[   67.725244]  snd_soc_acpi_intel_sdca_quirks snd_intel_dspcfg
intel_powerclamp snd_intel_sdw_acpi soundwire_generic_allocation
coretemp snd_soc_sdw_utils snd_soc_acpi iwlmld snd_hwdep kvm_intel
soundwire_bus mac80211 snd_soc_sdca kvm uvcvideo snd_soc_core ptp
processor_thermal_device_pci uvc ac97_bus processor_thermal_device
pps_core videobuf2_vmalloc snd_pcm_dmaengine
processor_thermal_power_floor snd_compress libarc4
processor_thermal_wt_hint videobuf2_memops spi_nor irqbypass
hid_sensor_custom_intel_hinge snd_pcm iTCO_wdt hid_sensor_als
hid_sensor_accel_3d hid_sensor_incl_3d hid_sensor_prox
hid_sensor_gyro_3d videobuf2_v4l2 hid_sensor_magn_3d
hid_sensor_rotation processor_thermal_wt_req intel_cstate mtd
intel_pmc_bxt mei_gsc_proxy snd_timer processor_thermal_rfim
hid_sensor_trigger videobuf2_common iwlwifi intel_uncore snd kfifo_buf
processor_thermal_mbox videodev btintel_pcie i2c_i801
hid_sensor_iio_common intel_pmc_core platform_temperature_control
soundcore spi_intel_pci i2c_smbus btintel pcspkr mc wmi_bmof
[   67.725309]  dptf_power msi_wmi int3403_thermal msi_wmi_platform
spi_intel crc8 i2c_mux industrialio intel_hid pmt_telemetry
processor_thermal_rapl int3400_thermal soc_button_array cfg80211
acpi_tad bluetooth sparse_keymap acpi_thermal_rel intel_rapl_common
acpi_pad mei_me processor_thermal_soc_slider pmt_discovery
intel_pmc_ssram_telemetry pmt_class rfkill mei intel_vpu igen6_edac
int340x_thermal_zone joydev mousedev mac_hid sch_fq_codel dm_crypt
encrypted_keys trusted tee asn1_encoder hid_sensor_custom
intel_ishtp_hid xe ucsi_acpi drm_gpuvm typec_ucsi drm_gpusvm_helper
roles drm_buddy gpu_sched hid_multitouch aesni_intel typec nvme
drm_suballoc_helper drm_exec gf128mul nvme_core drm_display_helper
hid_sensor_hub nvme_keyring aead cec video nvme_auth i2c_hid_acpi
i2c_algo_bit intel_lpss_pci i2c_hid wmi intel_ish_ipc drm_ttm_helper
intel_lpss thunderbolt pinctrl_intel_platform ttm idma64 intel_vsec
intel_ishtp serio_raw msi_ec dm_mirror dm_region_hash dm_log dm_mod
i2c_dev ec_sys crypto_user pkcs8_key_parser
[   67.725393] ---[ end trace 0000000000000000 ]---
[   67.725395] RIP: 0010:hidinput_hid_event+0x5c/0x750
[   67.725400] Code: 4c 8b 76 68 41 83 f8 16 75 73 41 8b 76 30 8b 02
48 81 c7 20 1c 00 00 48 89 fb 0f 1f 40 00 48 8b 1b 48 39 fb 0f 84 af
06 00 00 <39> 73 e4 75 ef 48 83 fb 38 0f 84 a0 06 00 00 3d 44 00 85 00
0f 85
[   67.725403] RSP: 0018:ffffd28ac1283cc8 EFLAGS: 00010203
[   67.725406] RAX: 00000000000d003b RBX: 0000000000000000 RCX: 0000000000000000
[   67.725408] RDX: ffff8d73c83d7e88 RSI: 0000000000000007 RDI: ffff8d73c6415c20
[   67.725410] RBP: 0000000000000000 R08: 0000000000000016 R09: 0000000000000003
[   67.725413] R10: 0000000000000000 R11: ffffffffc070a6c0 R12: 0000000000000001
[   67.725415] R13: ffffffffc08c70d0 R14: ffff8d73c5bb4000 R15: ffff8d73c83d7e00
[   67.725417] FS:  0000000000000000(0000) GS:ffff8d7b7f6fb000(0000)
knlGS:0000000000000000
[   67.725420] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   67.725422] CR2: ffffffffffffffd6 CR3: 0000000642812005 CR4: 0000000108f72ef0
[   67.725424] PKRU: 55555554
[   67.725426] note: irq/108-CUST000[574] exited with irqs disabled
[   67.725458] Fixing recursive fault but reboot is needed!
```

I asked the tech support from CachyOS, They respond me this might be
caused by a upstream bug in this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=227312b4a65c

Here is my system setup:
- Device name: MSI Prestiage Flip 16 AI+ C3MTG
- Stylus: MSI Nano Pen (CUST0000:00 04F3:4516)
- Kernel version: 7.1.0
- CPU: Intel Core Ultra X7 358H
- Architecture: x86-64

Here are the logs of initializing the stylus:

```
[    2.200612] input: CUST0000:00 04F3:4516 as
/devices/pci0000:00/0000:00:19.0/i2c_designware.0/i2c-0/i2c-CUST0000:00/0018:04F3:4516.0003/input/input19
[    2.200696] input: CUST0000:00 04F3:4516 UNKNOWN as
/devices/pci0000:00/0000:00:19.0/i2c_designware.0/i2c-0/i2c-CUST0000:00/0018:04F3:4516.0003/input/input20
[    2.200765] input: CUST0000:00 04F3:4516 Stylus as
/devices/pci0000:00/0000:00:19.0/i2c_designware.0/i2c-0/i2c-CUST0000:00/0018:04F3:4516.0003/input/input21
[    2.200823] input: CUST0000:00 04F3:4516 UNKNOWN as
/devices/pci0000:00/0000:00:19.0/i2c_designware.0/i2c-0/i2c-CUST0000:00/0018:04F3:4516.0003/input/input23
[    2.200895] input: CUST0000:00 04F3:4516 UNKNOWN as
/devices/pci0000:00/0000:00:19.0/i2c_designware.0/i2c-0/i2c-CUST0000:00/0018:04F3:4516.0003/input/input24
[    2.200968] input: CUST0000:00 04F3:4516 UNKNOWN as
/devices/pci0000:00/0000:00:19.0/i2c_designware.0/i2c-0/i2c-CUST0000:00/0018:04F3:4516.0003/input/input25
[    2.201017] input: CUST0000:00 04F3:4516 UNKNOWN as
/devices/pci0000:00/0000:00:19.0/i2c_designware.0/i2c-0/i2c-CUST0000:00/0018:04F3:4516.0003/input/input26
```
