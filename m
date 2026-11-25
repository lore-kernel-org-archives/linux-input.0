Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603620;
	b=bpHq5g7qGL6z3YT243VxoIPOXJiP5IaLi3iXXMFSO490PlZ0CyxPNpRLXf/vPLCjP+cm
	 Unm2J66AqVe9D+NngKaPwTEUCPooXIEqTdkLxC/4kcR/f3X9+LqUUtrhBRnCklvmxgWlO
	 ss2PQdWTCv/ZAIDWNUaDikohTDdM1Bi21RqOblda4lbZXfCZ4EdBrCQUpKpl2hBiXWYM0
	 2pxozOKoPY/xP+cnNivs8tWLkYiGFdv49WowT50wanx+nH7j9Uc2FUMQHfFRvZzOSbZ2B
	 0VDS4DAQ/8Si2dSbSIvDu2YmhIg5oAbRI94nVOBu0EDJ5XVbNpOrKP0f7KZtedDXDlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603620;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:Organization:References:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=C/aP/NM3do00PvSKy0j3vmDHQDzRIU+EthYpaY/VrUs=;
	b=KTRdLK5eCN1fbqLJytWQoezlGfnzFYTtAz5ZbbCz66wCD4zXe4WrF2nf2/8kMCUqnbjA
	 dYVd7BAo0HYGjlLxcCb6qxy7Va4y95C8YS+xjziRkXpDZ1kYbXUB3ZoBk0rqfI3trcNqV
	 Uhu9Aqbne/0QqYRRzHkrh0S5v12B12sCMUNWetsXsWjpKq9zFX9yp2/dE8S9oUDYcZzrH
	 MdMFF1xzZmhK8YwJUMYRbL15hDRULR2w1j36VDHgr/Cw6klcdFFddMU2ZgNTTSBm0DCT/
	 HKbcACndRMED5UI6/dQD3Hyjzvuka4jsbu9F7Oq0NTgHBBiDSzQyJAfc779jZWC63og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PJ8vaGPq;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3E606A31E;
	Wed, 25 Nov 2026 10:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9C3E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PJ8vaGPq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795603620; x=1827139620;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ppic9Wb5AnDH/xDYDG9AIfElTtzrxzInMPOwz110ry0=;
  b=PJ8vaGPqsHXs/R0TCCtuWm9UsgNjH3LxMUbtRoCA0rQpakGS/1iDCMCu
   7/Xpse8S3Cz3DkEhLW/TFCBqqD/pG1VrYZmUWbVJxwyWrhanXIuudBXil
   QpDOSE/gj4clmMpAKYsNZtVGDddPyRC762cYmZvMc/2uXTOyylcRJzChl
   pbkoew1+f2AovP1UvLNvOTaBXkxPuMICw8CW6FXQdUa3Rw8JYIsHU/AeB
   tQMnL6/XZ5AEaSuSXT98hkgwo2I3V6T6/2iT12FCwmAZ2ZhFU8ByilAxj
   ITdE47hcOh4HrtuF17RJ/76lA9IG+k7MU66zgqnKCQXtvAC4ZctVrIHaL
   A==;
X-CSE-ConnectionGUID: heP0+QgmT5Sgb6z6QuyKdg==
X-CSE-MsgGUID: 7zPGlOHZQ5SqNXRWZwdKJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4363125"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4363125"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 02:46:59 -0800
X-CSE-ConnectionGUID: CUWN79kcRii0wl9orE4MtA==
X-CSE-MsgGUID: vEmYBW59SGmHfGjRYmng+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="12052559"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 02:46:56 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk@kernel.org,
 conor+dt@kernel.org, dmitry.torokhov@gmail.com, Hefei <3066883572@qq.com>
Subject: Re: [PATCH v6 0/6] Add VIEWE 7" JD9365TX MIPI-DSI panel support
In-Reply-To: <tencent_C93E80ACC0BEB9083D9EE87E575073C67D09@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <tencent_C93E80ACC0BEB9083D9EE87E575073C67D09@qq.com>
Date: Wed, 25 Nov 2026 12:46:54 +0200
Message-ID: <2c928c89d9ae84be62cefc2b6ba638282ca0efa1@intel.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 25 Nov 2026, Hefei <3066883572@qq.com> wrote:
> Hi,
>
> This series adds support for the VIEWE 7KF82 7" 720x1280 in-cell MIPI-DSI
> panel based on Jadard JD9365TX (2-lane video mode), plus the companion
> I2C touchscreen and I2C backlight MCU used on the same FPC.

You really need to figure out and fix your git format-patch/send-email
setup to thread your series properly. The patches should be in-reply-to
the cover letter. Now they've been sent separately. The in-reply-to in
the patches point at non-existent messages.

BR,
Jani.

>
> This is a different programming model from the existing JD9365DA driver
> (panel-jadard-jd9365da-h3.c): page select uses 0xDE (not 0xE0), bring-up
> uses 0xDF unlock, and lane config is via 0xCC rather than 0x80.
>
> Tested on Raspberry Pi 4 and Raspberry Pi 5 with a downstream dtoverlay
> (not included here):
>   https://github.com/raspberrypi/linux/pull/7633
>
> Changes in v6:
> - Run checkpatch / checkpatch --strict; add MAINTAINERS entries
> - panel: drm_of_get_panel_orientation(); mipi_dsi_dcs_write_seq_multi()
> - touch: usleep_range for short delays
> - backlight: expand Kconfig help text
>
> Please prefer this v6 over earlier revisions.
>
> Thanks,
> Hefei
>
> Hefei (6):
>   dt-bindings: display: add VIEWE 7KF82 JD9365TX panel
>   dt-bindings: input: add Jadard JD9365TX touchscreen
>   dt-bindings: backlight: add VIEWE 7KF82 I2C backlight
>   drm/panel: add VIEWE JD9365TX 7 inch DSI panel
>   Input: add Jadard JD9365TX in-cell touchscreen driver
>   backlight: add VIEWE 7KF82 I2C backlight driver

-- 
Jani Nikula, Intel
