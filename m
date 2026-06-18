Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9BC346E51
	for <linux-input@vger.kernel.org>; Thu, 18 Jun 2026 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773617; cv=pass; b=E4RoujlPBvUHKUJLqoyzp/SIb3PX6ozyLlJfs7kZRNN5B4NukEYjW83/LncELZKsMPvqZgBdgcihX67ri+vWB1xsmHhe6i8YqCAET18g/VBw9XZUYgo+mHV4NnwoWSvnCg+SNfIKLEu50y2KzpxiBNZ5oUMFXPdPIS/aNlM5kQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773617; c=relaxed/simple;
	bh=2RHynbmkpZ2a3w7W50VOBhcSkYOgrz5ttFxfJNqnId8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=X5pYYkCR/rXV8URL2XkTT88h2wzBSaAj5A/LpdvUFDilmxC2wv3yNCsgphxFyyJom5Nz5uuIpSbBNlfGesjU/dI/8+0P95teI0Mwdy5YbulZ49fYaNSLeM1hicPNZrYr44C21/teqEFADPYVb+o9JMEkfxuWBNEh3/OGstEpYD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SggKJ/HY; arc=pass smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SggKJ/HY"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so411686a91.3
        for <linux-input@vger.kernel.org>; Thu, 18 Jun 2026 02:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781773615; cv=none;
        d=google.com; s=arc-20240605;
        b=R3pUGNdOZjjfpJywEOKcDtBnsPS33re3EH50gj1h3ltiVuGMNm3AqMgdDFHLR25NHe
         aLDEswgNAIW0BJIiQzi2vq8CgJNN8LqDEPGnnK2AQAGPniRkK82sq07QXU03gi3ohQHB
         84d6Bf/AQiQLLVpcPhMMTQVVhoKDev+Bcf/JoDRwJhOwUJtqPX1o8MpHUZGoFnF/b3Df
         tD0k18kCidKakc59tN8OBUcs6NtFOIj69iRlDGr/EqjrVSgeTrxKdgRpQ5E3YACyJiHg
         dklXYStQUlg/yAV4pWvhDZ7gU8z7Ud54PTAV2wF9J/ichaOK3gAB8gmfeGa9QkGCwGq3
         4PWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=sxjYegbaPEihhmMge3MDxgdyOBPiipz0fV3K5PxHzKk=;
        fh=XCAiEyLed+3Wy/JFKbXSo6Gm98oXHTg7mOYh0oyYbAA=;
        b=iSfBB24FYztteEGz1uBrXF4ZeBrMrT3m6oiKSenXzxGoFREApaMXLLa/WmrJFjArl9
         cNsSREXX9vRiOOG8akD121xCoy09downaWO8OnDZ5I+p/4OyxdKK7DHqkBM8iWff0QIu
         n8vdFGFmrIf6rfw3qh5aFQ5oRGQK54Xvrciw96nGQFLaHG5nURV52v6rVWwL0A+rAm59
         9z3Rn2T0t/riKPc6hM6KAFoo2ROcFXu47nuySflgk/gCKgz9QQIMoKPev+WnZgE6PuJ7
         e/1Sw3yAhyzEnbTEynjvqy9mPOs+u/pwKDd7bcnFst1+s83ZNLMOI7DGBDYEZZ5EsDM+
         qEvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781773615; x=1782378415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sxjYegbaPEihhmMge3MDxgdyOBPiipz0fV3K5PxHzKk=;
        b=SggKJ/HYo0FVJAo+x9rcgE3QssjwDCR+N/Y42KpNGAwOsFJPUVsblsXt4gHorQlfkQ
         sJ3rQtzXlgdfKxlHFlTXvGxj8M5UXEWw50XcinY/ZlGlAxxp9p9qVn4+6KDNKicPLZQS
         F23dUu+J9hUEArfKM4ckkicd2Ii8LIHBg0kwasNsivB5DCbS2wFQ+pK7kPsV07Ca0N9W
         Wk4jRXE3tLUNc39Q7CJdnLnafgzGYH2WHbVuMTzni3Ed9BgiaYUNSoU8PBZp39Ylmr9P
         UzQb3jCxdX27yP7jh3URMyRI25rhfU5oVZjZyhtRksoXRtUfSoQEwCuYCeyMumFqAPxu
         MJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781773615; x=1782378415;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxjYegbaPEihhmMge3MDxgdyOBPiipz0fV3K5PxHzKk=;
        b=LGUQ5veLvtpJ0t1pJAxl5slTS/Q05Du6Rfh7rkra7sC4GLB0P7+u3jhIUe/fmAuXma
         xhNt5HHsGmr1SCSEIQqX7mVTyJk79cifx+BW6eCSAJq6u5bU6wvyMdkDQh+yoN/V4T9Y
         MK/Zsyx+Gbz27q0WiyCBV5z87Vr0rgkS6XjNnKwpaJyqrgcXJ/i7CQ+RDXH69DX+xSEK
         qdPyEFAbGETqSw7xq4p5VgvkKKjAGrL3NR1Ml2mG06S/on+eR9a3aAOpBgB396OfXh1z
         ifMEsZoiou7f5Ceig3NobVsvhbYqDHSZRqmePWVlcIN4VN5FT8C8tmbKrgI7XzqcE78s
         RCNA==
X-Gm-Message-State: AOJu0Yx5a2yKcVo5tE5oMg1lccjVuQcYO02fybNTJqZ3OQkoKdAg5lf7
	0AmCAKTQ/MpUbdXEGtoGtX9AcGM2+uUpXLbWaBbfc+uiNOqdiF0Y9XQdr1jSRIndc9976qVbYti
	GERv9AsFRLrQefkfo7y1YPGeWJRMYMq8Vz4J7oQXWPNKTxTo=
X-Gm-Gg: AfdE7cnK1nR+d+Bc6O+oYOhtd2i/rdGtsQjZzOBXlaIBfYfXR4eKj1naXZvpeW373ci
	eFPtFvm6H3u+pS8rydAKjf1n8dJip3ccuWYX6TNp4EsiJ0pY1YimCeDYcMVFOSOYU5q8KaAPJJp
	hi+rDORrzWAFobP64KecgLQLZm5cLH4zoyCuAgjAEm9ueWup3JREXwIUngR5lkgtwNetDTtr+6y
	92DGMB6DZldcK4RU/7cFvuF588zwrW7GkXt0s9GRahv0ZlmMVd8/fXsIrmGIYcRMiRsSN6o2ZNS
	ZhdT4Q==
X-Received: by 2002:a17:90b:390f:b0:375:2a38:1d40 with SMTP id
 98e67ed59e1d1-37c9369f042mr8112829a91.20.1781773615375; Thu, 18 Jun 2026
 02:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Lin <ericlin050914@gmail.com>
Date: Thu, 18 Jun 2026 17:06:43 +0800
X-Gm-Features: AVVi8Ccx4hN5TrIBfQwBjsf_GCt3pGKS6TXDjTEMCcxyXv9lhfGHMmaYgk7YKrI
Message-ID: <CAFb0CM1X8_rxdfJGM-1D6i0=KDtv9tbMbuWi+PKAhTSMT+5NnA@mail.gmail.com>
Subject: [BUG] Bug report in HID: input: Add HID_BATTERY_QUIRK_DYNAMIC for
 Elan touchscreens
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, I found a bug booting Linux 7.1 on my MSI Prestiage 16 Flip AI+,
when I unplugged the embedded stylus (MSI Nano Pen) from this laptop,
I got kernel OOPS.

Here are the relevant logs I got from `dmesg`

```
[   44.523130] BUG: unable to handle page fault for address: ffffffffffffffe4
[   44.523146] #PF: supervisor read access in kernel mode
[   44.523151] #PF: error_code(0x0000) - not-present page
[   44.523156] PGD 767025067 P4D 767025067 PUD 767027067 PMD 0
[   44.523164] Oops: Oops: 0000 [#1] SMP NOPTI
[   44.523172] CPU: 3 UID: 0 PID: 567 Comm: irq/108-CUST000 Not
tainted 7.1.0-1-mainline #1 PREEMPT(full)
4b7fa715112ff45ec03c02ca0cc4f3e6646a47e2
[   44.523180] Hardware name: Micro-Star International Co., Ltd.
Prestige 16 Flip AI+ C3MTG/MS-2622, BIOS E2622IMS.117 04/27/2026
[   44.523184] RIP: 0010:hidinput_hid_event+0x3b1/0xad0
[   44.523197] Code: 1f 40 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 66
2e 0f 1f 84 00 00 00 00 00 48 8b 46 38 48 8d 70 c8 48 39 c2 0f 84 ef
fd ff ff <3b> 4e 1c 75 ea 48 85 f6 0f 84 e1 fd ff ff 41 8b 00 3d 44 00
85 00
[   44.523202] RSP: 0018:ffffcb8ac13f7cc8 EFLAGS: 00010282
[   44.523208] RAX: 0000000000000000 RBX: ffff8b7b862d6000 RCX: 0000000000000007
[   44.523212] RDX: ffff8b7b862d7c20 RSI: ffffffffffffffc8 RDI: ffff8b7b862d6000
[   44.523215] RBP: 0000000000000001 R08: ffff8b7b88267288 R09: 0000000000000000
[   44.523217] R10: ffff8b7baa294000 R11: ffff8b7b88267200 R12: ffff8b7b88267288
[   44.523219] R13: ffff8b7b862d6000 R14: ffffffffc0954100 R15: ffff8b7b88267200
[   44.523223] FS:  0000000000000000(0000) GS:ffff8b8348813000(0000)
knlGS:0000000000000000
[   44.523227] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.523231] CR2: ffffffffffffffe4 CR3: 0000000767022005 CR4: 0000000108f72ef0
[   44.523235] PKRU: 55555554
[   44.523237] Call Trace:
[   44.523243]  <TASK>
[   44.523256]  hid_process_event+0x118/0x130
[   44.523267]  hid_report_raw_event+0x367/0x530
[   44.523276]  __hid_input_report+0x178/0x240
[   44.523284]  ? pm_wakeup_dev_event+0x30/0x70
[   44.523294]  ? __pfx_irq_thread_fn+0x10/0x10
[   44.523305]  hid_safe_input_report+0x14/0x20
[   44.523316]  i2c_hid_irq+0xcf/0x170 [i2c_hid
bde5e468c566fa9b3a9febe814b6fe7c454afeff]
[   44.523327]  irq_thread_fn+0x25/0x60
[   44.523336]  irq_thread+0x1cb/0x330
[   44.523343]  ? __pfx_irq_thread_dtor+0x10/0x10
[   44.523351]  ? __pfx_irq_thread+0x10/0x10
[   44.523358]  kthread+0xe1/0x120
[   44.523367]  ? __pfx_kthread+0x10/0x10
[   44.523373]  ret_from_fork+0x2a7/0x330
[   44.523381]  ? __pfx_kthread+0x10/0x10
[   44.523386]  ret_from_fork_asm+0x1a/0x30
[   44.523398]  </TASK>
[   44.523400] Modules linked in: snd_seq_dummy rfcomm snd_hrtimer
snd_seq snd_seq_device ccm algif_aead des_generic libdes md4
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_limit
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uhid algif_hash
algif_skcipher af_alg nf_tables bnep nfnetlink f2fs vfat
lz4hc_compress fat lz4_compress snd_ctl_led snd_soc_sof_sdw
snd_sof_probes snd_soc_intel_hda_dsp_common snd_soc_rt712_sdca
snd_soc_rt1320_sdw regmap_sdw_mbq snd_hda_codec_intelhdmi regmap_sdw
snd_hda_codec_hdmi snd_soc_dmic snd_hda_intel snd_sof_pci_intel_ptl
snd_sof_pci_intel_lnl snd_sof_pci_intel_mtl snd_sof_intel_hda_generic
soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common
snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda
soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils
snd_hda_ext_core snd_hda_codec snd_hda_core snd_intel_dspcfg
intel_rapl_msr snd_intel_sdw_acpi intel_uncore_frequency
intel_uncore_frequency_common snd_soc_acpi_intel_match
intel_tcc_cooling
[   44.523493]  snd_soc_acpi_intel_sdca_quirks x86_pkg_temp_thermal
soundwire_generic_allocation intel_powerclamp snd_soc_sdw_utils
coretemp snd_soc_acpi snd_hwdep soundwire_bus uvcvideo iwlmld
kvm_intel spi_nor snd_soc_sdca iTCO_wdt videobuf2_vmalloc
intel_pmc_bxt mac80211 mtd snd_soc_core uvc
processor_thermal_device_pci mei_gsc_proxy snd_compress kvm ptp
videobuf2_memops videobuf2_v4l2 processor_thermal_device pps_core
ac97_bus processor_thermal_wt_hint videobuf2_common libarc4 irqbypass
snd_pcm_dmaengine intel_cstate platform_temperature_control snd_pcm
hid_sensor_gyro_3d hid_sensor_custom_intel_hinge hid_sensor_rotation
hid_sensor_accel_3d hid_sensor_prox hid_sensor_incl_3d hid_sensor_als
hid_sensor_magn_3d processor_thermal_soc_slider snd_timer i2c_i801
hid_sensor_trigger dptf_power intel_uncore int3403_thermal
intel_pmc_core btintel_pcie processor_thermal_rfim videodev iwlwifi
kfifo_buf snd i2c_smbus processor_thermal_rapl hid_sensor_iio_common
btintel soundcore spi_intel_pci pcspkr pmt_telemetry wmi_bmof mc
[   44.523586]  msi_wmi_platform msi_wmi i2c_mux crc8 industrialio
int3400_thermal intel_rapl_common spi_intel intel_hid pmt_discovery
soc_button_array bluetooth acpi_thermal_rel acpi_pad acpi_tad
sparse_keymap cfg80211 processor_thermal_wt_req pmt_class mei_me
processor_thermal_power_floor processor_thermal_mbox mei intel_vpu
intel_pmc_ssram_telemetry rfkill int340x_thermal_zone igen6_edac
joydev mousedev mac_hid dm_crypt encrypted_keys trusted asn1_encoder
tee hid_sensor_custom intel_ishtp_hid xe drm_gpuvm drm_gpusvm_helper
drm_buddy ucsi_acpi gpu_sched typec_ucsi drm_exec roles hid_multitouch
drm_suballoc_helper aesni_intel video typec drm_ttm_helper gf128mul
hid_sensor_hub aead ttm nvme i2c_algo_bit i2c_hid_acpi wmi i2c_hid
nvme_core drm_display_helper intel_lpss_pci intel_ish_ipc nvme_keyring
intel_lpss pinctrl_intel_platform nvme_auth thunderbolt intel_ishtp
cec intel_vsec idma64 serio_raw dm_mirror dm_region_hash dm_log dm_mod
i2c_dev crypto_user ec_sys pkcs8_key_parser
[   44.523684] CR2: ffffffffffffffe4
[   44.523689] ---[ end trace 0000000000000000 ]---
[   44.523694] RIP: 0010:hidinput_hid_event+0x3b1/0xad0
[   44.523699] Code: 1f 40 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 66
2e 0f 1f 84 00 00 00 00 00 48 8b 46 38 48 8d 70 c8 48 39 c2 0f 84 ef
fd ff ff <3b> 4e 1c 75 ea 48 85 f6 0f 84 e1 fd ff ff 41 8b 00 3d 44 00
85 00
[   44.523702] RSP: 0018:ffffcb8ac13f7cc8 EFLAGS: 00010282
[   44.523705] RAX: 0000000000000000 RBX: ffff8b7b862d6000 RCX: 0000000000000007
[   44.523708] RDX: ffff8b7b862d7c20 RSI: ffffffffffffffc8 RDI: ffff8b7b862d6000
[   44.523710] RBP: 0000000000000001 R08: ffff8b7b88267288 R09: 0000000000000000
[   44.523711] R10: ffff8b7baa294000 R11: ffff8b7b88267200 R12: ffff8b7b88267288
[   44.523713] R13: ffff8b7b862d6000 R14: ffffffffc0954100 R15: ffff8b7b88267200
[   44.523715] FS:  0000000000000000(0000) GS:ffff8b8348813000(0000)
knlGS:0000000000000000
[   44.523718] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.523720] CR2: ffffffffffffffe4 CR3: 0000000767022005 CR4: 0000000108f72ef0
[   44.523723] PKRU: 55555554
[   44.523726] note: irq/108-CUST000[567] exited with irqs disabled
[   44.523748] kernel tried to execute NX-protected page - exploit
attempt? (uid: 0)
[   44.523751] BUG: unable to handle page fault for address: ffff8b7ba8969bc0
[   44.523753] #PF: supervisor instruction fetch in kernel mode
[   44.523756] #PF: error_code(0x0011) - permissions violation
[   44.523758] PGD 768201067 P4D 768201067 PUD 87f7ff067 PMD 10a5a6063
PTE 8000000128969163
[   44.523764] Oops: Oops: 0011 [#2] SMP NOPTI
[   44.523769] CPU: 3 UID: 0 PID: 567 Comm: irq/108-CUST000 Tainted: G
     D             7.1.0-1-mainline #1 PREEMPT(full)
4b7fa715112ff45ec03c02ca0cc4f3e6646a47e2
[   44.523774] Tainted: [D]=DIE
[   44.523776] Hardware name: Micro-Star International Co., Ltd.
Prestige 16 Flip AI+ C3MTG/MS-2622, BIOS E2622IMS.117 04/27/2026
[   44.523778] RIP: 0010:0xffff8b7ba8969bc0
[   44.523873] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 <00> 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
03 00
[   44.523876] RSP: 0018:ffffcb8ac13f7eb8 EFLAGS: 00010286
[   44.523880] RAX: ffff8b7ba8969bc0 RBX: 96f2eb95fa502b00 RCX: 0000000000000000
[   44.523883] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffcb8ac13f7ea0
[   44.523885] RBP: ffff8b7ba8969bc0 R08: 0000000000000000 R09: 0000000000000000
[   44.523888] R10: ffffcb8ac13f7de8 R11: ffffcb8ac13f7de0 R12: 0000000000000009
[   44.523891] R13: ffff8b7ba8970000 R14: ffff8b7ba8969b01 R15: 0000000000000000
[   44.523893] FS:  0000000000000000(0000) GS:ffff8b8348813000(0000)
knlGS:0000000000000000
[   44.523896] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.523899] CR2: ffff8b7ba8969bc0 CR3: 0000000767022005 CR4: 0000000108f72ef0
[   44.523902] PKRU: 55555554
[   44.523905] Call Trace:
[   44.523909]  <TASK>
[   44.523911]  ? task_work_run+0x66/0xa0
[   44.523920]  ? do_exit+0x300/0xba0
[   44.523930]  ? make_task_dead+0x8d/0x90
[   44.523936]  ? rewind_stack_and_make_dead+0x16/0x20
[   44.523946]  </TASK>
[   44.523948] Modules linked in: snd_seq_dummy rfcomm snd_hrtimer
snd_seq snd_seq_device ccm algif_aead des_generic libdes md4
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_limit
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 uhid algif_hash
algif_skcipher af_alg nf_tables bnep nfnetlink f2fs vfat
lz4hc_compress fat lz4_compress snd_ctl_led snd_soc_sof_sdw
snd_sof_probes snd_soc_intel_hda_dsp_common snd_soc_rt712_sdca
snd_soc_rt1320_sdw regmap_sdw_mbq snd_hda_codec_intelhdmi regmap_sdw
snd_hda_codec_hdmi snd_soc_dmic snd_hda_intel snd_sof_pci_intel_ptl
snd_sof_pci_intel_lnl snd_sof_pci_intel_mtl snd_sof_intel_hda_generic
soundwire_intel snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda_common
snd_soc_hdac_hda snd_sof_intel_hda_mlink snd_sof_intel_hda
soundwire_cadence snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils
snd_hda_ext_core snd_hda_codec snd_hda_core snd_intel_dspcfg
intel_rapl_msr snd_intel_sdw_acpi intel_uncore_frequency
intel_uncore_frequency_common snd_soc_acpi_intel_match
intel_tcc_cooling
[   44.524031]  snd_soc_acpi_intel_sdca_quirks x86_pkg_temp_thermal
soundwire_generic_allocation intel_powerclamp snd_soc_sdw_utils
coretemp snd_soc_acpi snd_hwdep soundwire_bus uvcvideo iwlmld
kvm_intel spi_nor snd_soc_sdca iTCO_wdt videobuf2_vmalloc
intel_pmc_bxt mac80211 mtd snd_soc_core uvc
processor_thermal_device_pci mei_gsc_proxy snd_compress kvm ptp
videobuf2_memops videobuf2_v4l2 processor_thermal_device pps_core
ac97_bus processor_thermal_wt_hint videobuf2_common libarc4 irqbypass
snd_pcm_dmaengine intel_cstate platform_temperature_control snd_pcm
hid_sensor_gyro_3d hid_sensor_custom_intel_hinge hid_sensor_rotation
hid_sensor_accel_3d hid_sensor_prox hid_sensor_incl_3d hid_sensor_als
hid_sensor_magn_3d processor_thermal_soc_slider snd_timer i2c_i801
hid_sensor_trigger dptf_power intel_uncore int3403_thermal
intel_pmc_core btintel_pcie processor_thermal_rfim videodev iwlwifi
kfifo_buf snd i2c_smbus processor_thermal_rapl hid_sensor_iio_common
btintel soundcore spi_intel_pci pcspkr pmt_telemetry wmi_bmof mc
[   44.524118]  msi_wmi_platform msi_wmi i2c_mux crc8 industrialio
int3400_thermal intel_rapl_common spi_intel intel_hid pmt_discovery
soc_button_array bluetooth acpi_thermal_rel acpi_pad acpi_tad
sparse_keymap cfg80211 processor_thermal_wt_req pmt_class mei_me
processor_thermal_power_floor processor_thermal_mbox mei intel_vpu
intel_pmc_ssram_telemetry rfkill int340x_thermal_zone igen6_edac
joydev mousedev mac_hid dm_crypt encrypted_keys trusted asn1_encoder
tee hid_sensor_custom intel_ishtp_hid xe drm_gpuvm drm_gpusvm_helper
drm_buddy ucsi_acpi gpu_sched typec_ucsi drm_exec roles hid_multitouch
drm_suballoc_helper aesni_intel video typec drm_ttm_helper gf128mul
hid_sensor_hub aead ttm nvme i2c_algo_bit i2c_hid_acpi wmi i2c_hid
nvme_core drm_display_helper intel_lpss_pci intel_ish_ipc nvme_keyring
intel_lpss pinctrl_intel_platform nvme_auth thunderbolt intel_ishtp
cec intel_vsec idma64 serio_raw dm_mirror dm_region_hash dm_log dm_mod
i2c_dev crypto_user ec_sys pkcs8_key_parser
[   44.524222] CR2: ffff8b7ba8969bc0
[   44.524225] ---[ end trace 0000000000000000 ]---
[   44.524228] RIP: 0010:hidinput_hid_event+0x3b1/0xad0
[   44.524233] Code: 1f 40 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 66
2e 0f 1f 84 00 00 00 00 00 48 8b 46 38 48 8d 70 c8 48 39 c2 0f 84 ef
fd ff ff <3b> 4e 1c 75 ea 48 85 f6 0f 84 e1 fd ff ff 41 8b 00 3d 44 00
85 00
[   44.524236] RSP: 0018:ffffcb8ac13f7cc8 EFLAGS: 00010282
[   44.524240] RAX: 0000000000000000 RBX: ffff8b7b862d6000 RCX: 0000000000000007
[   44.524243] RDX: ffff8b7b862d7c20 RSI: ffffffffffffffc8 RDI: ffff8b7b862d6000
[   44.524246] RBP: 0000000000000001 R08: ffff8b7b88267288 R09: 0000000000000000
[   44.524249] R10: ffff8b7baa294000 R11: ffff8b7b88267200 R12: ffff8b7b88267288
[   44.524252] R13: ffff8b7b862d6000 R14: ffffffffc0954100 R15: ffff8b7b88267200
[   44.524255] FS:  0000000000000000(0000) GS:ffff8b8348813000(0000)
knlGS:0000000000000000
[   44.524258] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.524261] CR2: ffff8b7ba8969bc0 CR3: 0000000767022005 CR4: 0000000108f72ef0
[   44.524264] PKRU: 55555554
[   44.524267] note: irq/108-CUST000[567] exited with irqs disabled
[   44.524294] Fixing recursive fault but reboot is needed!
```
