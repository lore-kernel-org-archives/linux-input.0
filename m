Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8C38B12E
	for <linux-input@vger.kernel.org>; Mon,  1 Jun 2026 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349466; cv=none; b=ovrOa1WqGt2yykPdANSaZfr3bK78LTx+dPRMxNLARbaBb1hCKz0IJjA7EeB07WcRPs9ZPfXtCSv327i+jE1UXnvDk+abzkMFyQrjBugxnv2TTmTM1F/NwJM94DGW9dRV0merQXFUw+sa+LTSVzbP3Xzr/PXzkbN1zMitMcDZ13Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349466; c=relaxed/simple;
	bh=6MrldId2ywvvgWK0Wzo/bX3+POPDX4YKXeI/F+3Jf1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=az573+334VL2QzCpepk9VTVV7Nu0TqiB1d8kXsI/6ptBAo6ZBbadxVd13B9cjUqXdYftbwkeqSnwZh04GdO+DFDLdiGWaF0SHkpCDe9BPYnIVfaimvk4oNkp1X0dPrXzHLVi86oQXUNoRPVgUmmqnpVfNjiwuJH7oVra8bVqflc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sc7Z/F1i; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sc7Z/F1i"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-490a7876f8cso17091365e9.3
        for <linux-input@vger.kernel.org>; Mon, 01 Jun 2026 14:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780349461; x=1780954261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrI9zRVmv7V6pta/kHysc7URPMQUcr9MORYitOpV7hQ=;
        b=sc7Z/F1igcfrSDObNR/maw70J5GMMo6L7InBlA4c8BW6lWru63/E9ZSJ+Z9XsYMJ+s
         Yr6fwiygl/xjq1DUAYnOgfnBTyBtDuslF5S/1pVUpeEmfQxPcWroiH/9DQTufRn9fsyh
         DBBWEhGIVgxut9JZLcVIIc7Pg1T7GzSVgOdun3f6n6NL6OBDLgY5sw5BZ0r8hKWEH8ZR
         irS/An9glVkOeY2HWPd3duADfr8tZRMKZwXYZlSEM1BmMkNhaGRPqPlzkqZCPhWRjb7z
         /DgxReZ8TqUqdlO+lU5oUkyLRe7OAXqTqois4qkHPVQNA5pUkT1RBY0HUWoXoK9qIFB4
         hPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780349461; x=1780954261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OrI9zRVmv7V6pta/kHysc7URPMQUcr9MORYitOpV7hQ=;
        b=Ky0eG6cnABuv8qns7J9Tth5g6ce33JmCD1p/kz/6fJoMLV4WMlhZF+hJLLNm0Y/QnU
         RvixYr//7LdoHUe6LQUclWxkoMq4O5g8dx45mVDYQ1saWANrGLtWTZxoTEc4TMChPYMN
         aCmA5VgxZSXJOVKRna03QRh+Rh/GPs0aX5RzcjdIMOoo3yVw+Xd8XF+sNYYZoTkcBVhW
         WyraB8JVFtYbzUCax02pVnw3AKtX6ZvINP9upMlpKesGzqA2qSobtVww/gCo5YZYlEa7
         auxIOCtvEk3x7qnsKq6NYNjrcYuG0CQb2OzQZFns+XmGXgruJSbp9W9tA0U1yotYprgx
         aWWg==
X-Forwarded-Encrypted: i=1; AFNElJ9znhTw7Y4Z6vOUcuqBg0OFc3wgiMBOSgHBfu8E7yQV4PNHGvd9dAoGAR67lspO3T6u1GLUF5flroLIxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvYifwVmMXgH+DbBX720G1gca4zit27/CFs3W9IvxIbNDG54X
	CS6/wlYoQe0ABumom+k4TTUfzsuJ4zRMKbjf0xMb0VyXGx5hPRRmyNe0
X-Gm-Gg: Acq92OF7pAJYcM8HvremnkF7yp9rsWFMGUDAnhvBmFKYpsfM4jovBod6UCOyTNHru7N
	iE5YVT7jH/c6EjafKN/QMf2w7p4iVsl9vquLrUrPRkuaTwvBdvQWH/Q20odrGMpjUJww5vE+sYz
	Hd6McKLbh0xptt4W67IWHxaYFlnKr6S85VGmLToL+YQd5cR3DPV9u59z5wBMMufjEPTvir5EDXD
	Q1DC6WlHeXKT42QmhTecBPUu3wUW4ySezYE/B+BdhYDYMMewC6utCem73GNoi4qI1o3gyQ18E+o
	n2f7SAoBAj2LFemua73ST7uC+vzD8RTjRmoPLNotg9Zb0z+nHyFX3RwkyE1CxqLIfI0bkkNSrZw
	fouBHUT+eM9XtAfTLxLA1jqWeNtXt/xfcCj+jEZoABCbP4UY1Bmzrz+Hgf9olWFqWO6gWb8bQdC
	edAyoGoDJ/uLITU7MLR42obDC4+H8xgx4tW5PwN+8Gnpa6t2iER8k1E/oJhn0zBcoxmX0AflxRz
	w84
X-Received: by 2002:a05:600c:1988:b0:490:845e:3a6 with SMTP id 5b1f17b1804b1-490a295013bmr227426615e9.25.1780349460880;
        Mon, 01 Jun 2026 14:31:00 -0700 (PDT)
Received: from machine (host-176-37-220-32.b025.la.net.ua. [176.37.220.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e0f343sm19662735e9.1.2026.06.01.14.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 14:31:00 -0700 (PDT)
From: d3z <d3z.the.dev@gmail.com>
To: even.xu@intel.com,
	xinpeng.sun@intel.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: "Danny D ." <d3z.the.dev@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	abhishektamboli9@gmail.com,
	sakari.ailus@linux.intel.com
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC on system resume
Date: Tue,  2 Jun 2026 00:30:46 +0300
Message-ID: <20260601213047.115271-1-d3z.the.dev@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <IA1PR11MB60985B856D77963E2DBE47F9F4152@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260529222210.1532876-1-d3z.the.dev@gmail.com> <IA1PR11MB60987CB2D72FD1701951DFA4F4152@IA1PR11MB6098.namprd11.prod.outlook.com> <IA1PR11MB60985B856D77963E2DBE47F9F4152@IA1PR11MB6098.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danny D. <d3z.the.dev@gmail.com>

Hi Even,

Thanks for the quick reply and for sharing your patch.

First, the missing piece from your mail: my name is Danny D.
(d3z.the.dev@gmail.com) - please use it for any
Signed-off-by/Reported-by/Tested-by.

One note on the starting assumption, though: in its current configuration
this Surface Pro 10 doesn't go to S3 at all. /sys/power/mem_sleep only
offers s2idle:

    $ cat /sys/power/mem_sleep
    [s2idle]

There's no "deep" entry to select here, so every suspend goes through
s2idle and never reaches PM_SUSPEND_MEM. The touch IC still loses power
across that s2idle suspend - the same as over hibernation - which is what
gives the "recv failed: -11" on resume.

That's the catch with the attached patch: it gates the THC reconfigure on

    if (last_suspend_state == PM_SUSPEND_MEM)

i.e. S3 only. On this machine that branch never runs, so it wouldn't bring
the touchscreen back here. Happy to apply it and confirm on the device, but
from the code path alone it can't help while we're s2idle-only.

What I did instead was key off whether the device actually kept power
rather than the suspend type: run the full reset only when the device isn't
a wake source (device_may_wakeup() == false), mirroring quickspi_restore().
A wake-enabled device stays on the light path so wake-on-touch is preserved;
one that lost power goes through reset_tic() re-enumeration. That fires on
both s2idle and S3, which is what makes it work on the SP10.

I've tested this on the Surface Pro 10 across many s2idle suspend/resume
cycles - touch and pen both keep working - and just posted a v2 that adds
the device_may_wakeup() gate.

Could we converge on the wakeup-based condition? I'm glad to test any
revision of your patch on the hardware, and equally glad for you to carry
the fix with my Signed-off-by/Tested-by once it handles the s2idle case.

Thanks,
Danny
