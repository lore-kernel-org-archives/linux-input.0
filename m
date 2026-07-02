Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4879C3C061C;
	Thu,  2 Jul 2026 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031495; cv=none; b=SPSkBjVQprfh95QgeTeZBFJaPnrkeA3dnojNBSW+WinsA8zpJLsBUy257Jo1sQVe3r8jT7ujWuaDMYfTZfk3iVd1X5kIxjOULRby55dTbhgwinjWFMrRJcXQUlxsGpI8/6Y/lzMQYJaXuu2IqK5MBxmReYmPdYg5gYbE205snmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031495; c=relaxed/simple;
	bh=SSfcCWxuV134z4yJIajUuPr4SZ8YybLX0FBV8OrJ0cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGbh2fwh+LenBS0LnnjnS85SS/50AN5TVPEtoZLZQYV6IOUqcuqtVJ7hIwCGwqD64bp8Ten6YqjNQIDcIxW0CaGM35AZpcf3L5lo14As0lOf5RSON2YTkUOZursbaLS3QzaOoVK0ypfpNqBmxyH+kRfK2JG+Y2Gfk7crss5Tvoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 250F820094B;
	Fri, 03 Jul 2026 00:31:26 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1wfPwM-005oQO-07;
	Fri, 03 Jul 2026 00:31:26 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1wfPwL-0000000DWDB-3os8;
	Fri, 03 Jul 2026 00:31:25 +0200
Date: Fri, 3 Jul 2026 00:31:25 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: andrew.thomas@touchnetix.com, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Marco Felsch <kernel@pengutronix.de>, 
	Henrik Rydberg <rydberg@bitmath.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, Mamta Shukla <mamta.shukla@leica-geosystems.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v6 0/4] Input: Add support for TouchNetix aXiom
 touchscreen
Message-ID: <kjymec57wxqdwd4f6kgagcnaj3lb53bcnkjhtvgah7pqu6jjq6@qnn6r6psbujv>
References: <20260703-v6-10-topic-touchscreen-axiom-v6-0-1aa50ba3bc5a@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-v6-10-topic-touchscreen-axiom-v6-0-1aa50ba3bc5a@pengutronix.de>

Hi,

Please ignore this patch series, for some reasons b4 made it v6 albeit
this should be v7. I will sind a new series with the correct version!

Regards,
  Marco

On 26-07-03, Marco Felsch wrote:
> Hi,
> 
> this adds the support for the TouchNetix aXiom touchcontroller family.
> 
> The following features are added:
>  - I2C communication
>  - Input event handling
>  - Touchcontroller firmware (AXFW) updates
>  - Touchcontroller config (TH2CFGBIN) updates
>  - Poll or IRQ support
> 
> Many thanks for Dmitry's input on my v5. I included all changes
> requested from him.
> 
> Regards,
>   Marco
> 
> Changes in v7:
> - Link to v6: https://lore.kernel.org/all/20260303-v6-10-topic-touchscreen-axiom-v6-0-8ac755add12b@pengutronix.de/
> - Rebased on top of 7.2-rc1
> - Fix U33 rev.6 usage (Mamta)
> - Fix bootloader mode handling, required to disable the IRQ (Andrew)
> - Fix bug in usage table population which led to a nullptr bug (Andrew)
> 
> Changes in v6:
> - Link to v5: https://lore.kernel.org/r/20260111-v6-10-topic-touchscreen-axiom-v5-0-f94e0ae266cb@pengutronix.de
> - Fix update POLL mode
> - Fix max. input values
> - Resolve some "TODO" and "Downstream" comments (Andrew)
> - Add 0d, xl fw_variant (Andrew)
> - Use 2sec timeout for u02 swreset (Andrew)
> - Fix IRQ-runmode input-device registration after FW update
> - Drop legacy ALC firmware support, since no fw sanity check could be performed
>   which is bad for user experience if they provided the wrong file accidentally.
> - drop BLP_PRE_MODE
> - make AXIOM_U31 rev.1 required
> - axiom_usage_supported: drop iter and instead use new usage_table_by_baseaddr
> - axiom_axfw_fw_write: drop goto error handling
> - adapt comments
> - rework axiom_i2c_probe (Dmitry)
> - rework axiom_power_*_device and axiom_parse_firmware (Dmitry)
> - rework axiom_register_input_dev (Dmitry)
> - rework axiom_register_fwl (Dmitry)
> - rework axiom_cfg_fw_cancel (Dmitry)
> - rework axiom_cfg_fw_write (Dmitry)
> - rework axiom_verify_volatile_mem (Dmitry)
> - rework axiom_write_cfg_chunk (Dmitry)
> - rework axiom_cfg_fw_prepare (Dmitry)
> - rework axiom_axfw_fw_* functions (Dmitry)
> - rework axiom_blp_reset (Dmitry)
> - rework axiom_blp_write_chunk (Dmitry)
> - rework axiom_enter_bootloader_mode (Dmitry)
> - rework axiom_axfw_fw_prepare (Dmitry)
> - rework regmap_read/write (Dmitry)
> - rework axiom_u34_rev1_process_report (Dmitry)
> - rework axiom_cdu_wait_idle (Dmitry)
> - rework axiom_u64_cds_enabled (Dmitry)
> - rework axiom_u42_get_touchslots (Dmitry)
> - rework axiom_u33_read (s/ret/error/) (Dmitry)
> - rework axiom_u31_device_discover (Dmitry)
> - simple s/ret/error/ (Dmitry)
> - rework u04 handling (Dmitry)
> - rework u02 handling (Dmitry)
> - align function name accordingly (Dmitry)
> - fix indentation (Dmitry)
> 
> Changes in v5:
> - Link to v4: https://lore.kernel.org/r/20260106-v6-10-topic-touchscreen-axiom-v4-0-9e9b69c84926@pengutronix.de
> - fix sysfs documentation description indentation and date
> 
> Changes in v4:
> - Link to v3: https://lore.kernel.org/r/20250821-v6-10-topic-touchscreen-axiom-v3-0-940ccee6dba3@pengutronix.de
> - rebased on top of v6.19-rc1
> - collect r-b tags
> 
> Changes in v3:
> - Link to v2: https://lore.kernel.org/r/20250529-v6-10-topic-touchscreen-axiom-v2-0-a5edb105a600@pengutronix.de
> - firmware: fix commit message (Russ)
> - dt-bindings: Add ack from Krzysztof
> - dt-bindings: make use of GPIO_ACTIVE_LOW (Krzysztof)
> - dt-bindings: drop 'panel: true' property (Krzysztof)
> - driver: make use of sysfs_emit (Greg)
> - driver: s/WARN()/dev_warn()/ to not take down the system (Greg)
> - driver: fix build dependency error by adding "depends on DRM || !DRM"
> - driver: harmonize usage printing to u%02X
> 
> Changes in v2:
> - Link to v1: https://lore.kernel.org/r/20241119-v6-10-topic-touchscreen-axiom-v1-0-6124925b9718@pengutronix.de
> - Rework the firmware-duplicate handling -> expose the error to the
>   userspace
> - Drop Krzysztof Kozlowski ACK and RB
> - Add panel-follower support
> - Add sysfs-driver-input-touchnetix-axiom documentation
> - Add support for new firmware 4.8.9
> - Add support to handle 2D and 3D firmware
> 
> ---
> Kamel Bouhara (2):
>       dt-bindings: vendor-prefixes: Add TouchNetix AS
>       dt-bindings: input: Add TouchNetix axiom touchscreen
> 
> Marco Felsch (2):
>       firmware_loader: expand firmware error codes with up-to-date error
>       Input: Add TouchNetix aXiom I2C Touchscreen support
> 
>  .../testing/sysfs-driver-input-touchnetix-axiom    |   80 +
>  .../input/touchscreen/touchnetix,ax54a.yaml        |   62 +
>  .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
>  drivers/base/firmware_loader/sysfs_upload.c        |    1 +
>  drivers/input/touchscreen/Kconfig                  |   17 +
>  drivers/input/touchscreen/Makefile                 |    1 +
>  drivers/input/touchscreen/touchnetix_axiom.c       | 3141 ++++++++++++++++++++
>  include/linux/firmware.h                           |    2 +
>  lib/test_firmware.c                                |    1 +
>  9 files changed, 3307 insertions(+)
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20240704-v6-10-topic-touchscreen-axiom-105761e81011
> 
> Best regards,
> -- 
> Marco Felsch <m.felsch@pengutronix.de>
> 
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
