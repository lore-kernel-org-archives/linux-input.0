Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AEE381EBC
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203532; cv=none; b=UBhHkjadw00SnjHQkAuD+FnkU17GFmG9fVa13zDhI9wAJfuH/CpC9ClOEWgmpyFaZoZ4AJsKaVAuFZc/VkTlDUCyl1SkHgBWQ/7wmuev2YVRB9vVl8yIJIjbULZ1PjYHREe9N3K3kEPPwazLYYOoAyI29PbXqsCNHGkoTy2rVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203532; c=relaxed/simple;
	bh=tWVcT6JwHJnc3d53UK7tUHvXHwCvOt2tIFjp3h4BWSs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PiIuimDkAWzT71p3MDNByRuvgPdC9kjNtn+0u3RMUHUDHIRI8SFFKwYFCzAhSBT/hRhHBTLGCdOoT7NNjSVx781I9VOFXmhdy6VKUZ65F5CjRBKMIkuDnq9MvzOAJAPa2ys9QuQ+Wd+yMEk4sLnDd3qNeCjAQQqFiT/gPr4CWHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy66AtbU; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy66AtbU"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-143880e27dfso402820c88.1
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 15:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790203529; x=1790808329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tMHazq21ogGHqSDoBKzZAYFbxPofg+lpr7Oo8QXp/yQ=;
        b=cy66AtbUJ1VkhLXnQaKRmtCBBoshqlI5ak+MjPdXfk+pX9Uv/pcaiLA2fuJC/C0u3O
         +SMUB3SWO7nJyBmJfJZmcsUWpPUrhAhGyPW5ZMqUWL8qMHijq1dy8tzjVy5FBo9TxYLH
         rpBPwmP7gWRax1WTlPqm3Po22hlUvO0Zy/C/XQdXQI18ulFQ9IwMia49aoubG4HCA83Y
         kxmevIpsnWdLuoeQil82/rvFaBZ8MEuIZxrjm5RyI/j0+5xDhUVJRaFX4uT1WhgfuXOh
         xmcH9kfY1C4MjOb3oNuUdOcZmMgJS2vMG+gkzzEJ32APi6y56R5kLV6qCnTMCmQ1SoeD
         YnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790203529; x=1790808329;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tMHazq21ogGHqSDoBKzZAYFbxPofg+lpr7Oo8QXp/yQ=;
        b=xF68aQRfyJyUErDg7H7V8+Gcdi1J43qEd577s19xtKDnrpllAnTwh5R/9YIuKy1qRt
         IYIV6vUQctslvZbonpCxU56NJ4Cel6XpNc4j3f491BlrBmaqibmt6OITeCDFwyIjv+yp
         C0W/G18XpDmYJOrGN0wktJou6VDJj5r+HzRxVTUmjyf0mwEzt+ymy2GbKcAqQERBKWGO
         7AdeT7VEdqn+Rmo1AN9MM419kS2/bjueP/qh1up4Jrnfvvhr0MBYqyDiLY4JS6jOItPj
         FxhqRBbmUuz7SFjw7DrJOfAe3bN37/bTOkiixXHDclP5jur31UhpPabIZbhwSdJ1WWCr
         anMg==
X-Forwarded-Encrypted: i=1; AKwUvBysxw5SmEjFJ1I9IZOYCmMZ0Q5Ocao6z8z15o33dptu0V7URzpUXLdQPbA9fn7mhZk198V5JaSurLY2zQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mbOzL2JC790aW+DuDu0sMwOS/m6V05kk4xNXJE7kG3y1GHA2hd
	cHzjPiLyqm7MdGuoknzs1Vbm0BoDcQ/P5oHsn7/KD6E7vVmhj8aVRrbHfpJZag==
X-Gm-Gg: AYBFou0RZB8CjBiVAF+NXFG3KVLAhVNxDi9iTn8ZeCrNEwSlOa6HJwUmplNJlekx1uh
	hkeEXIVSi4I9HEfKHDWp4/LfrYDYVtvksDJaPIGsyY3hrXMmJMPlm+r7lJAH3WE1xlYRb0thnR1
	v+ZBVK6RODpra+85hF/oPqxIBcnZ/JHlzaDd0RAcRJka/XqiWEyxdP/gwJLvFz8Iq0CdcbcFUwz
	ZtWYEEFUwKf02+vi3KwS63a7IzAO11qT+p28Uts2DuaFJ1gqZ5qUzKM13Ztd61XRL2TDWIoI+p2
	LbMENRzQGeF2PWLyS8ErZvTP83F6GNlRXO5ZUXDcYZ/P+kFdsTdeormM3pnkGujgUHLjDSbdhqL
	BWpTo/Hli3F4ol8zXjdo02+EmdTWH0I12MAvK5l2R+3djjNBw4cD6LeWFwUEPcigicr5KVCw8nE
	IOneguzhca7ycLYh9EJX//cGIKBGg3+wItVCb2ouyX65m4Bp3PJPeM3aKFy1iDFowr4m8rdJfOj
	eYjhXsuTpbFeU75utpZJ/EW0Hh3eb6TgeLbjE+YGfKPFrIfmLF2T9FZgKfFlW8msapU
X-Received: by 2002:a05:701b:4286:10b0:143:2968:564d with SMTP id a92af1059eb24-14503fde4dcmr416556c88.27.1790203529383;
        Wed, 23 Sep 2026 15:45:29 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f9877462sm7915545c88.10.2026.09.23.15.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 15:45:28 -0700 (PDT)
Date: Wed, 23 Sep 2026 15:45:28 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Aditya Dash <mradityadash@gmail.com>
CC: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_5/7=5D_HID=3A_hid-lenovo-go?=
 =?US-ASCII?Q?=3A_normalize_calibration_failure_status?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260923211458.32755-1-mradityadash@gmail.com>
References: <836F1B09-60CA-4A82-8293-0F9CF506E593@gmail.com> <20260923211458.32755-1-mradityadash@gmail.com>
Message-ID: <71564420-F3C8-4963-82B4-D23A6815D688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 23, 2026 2:14:58 PM PDT, Aditya Dash <mradityadash@gmail=2Ecom=
> wrote:
>Hi Derek,
>
>According to my observations, data[1] seems to give the correct status
>instead of data[0]=2E
>
>device_type in cmd_rep seems to indicate the left or right controller, an=
d
>data[0] the calibration device (gyro, joystick, or trigger)=2E
>
>To validate that, I ran the left gyro calibration on my Legion Go 1
>and failed it on purpose=2E
>
>Here is the raw data alongside cmd_rep, its contents, and data array
>
>  raw        04 00 a0 02 03 01 02 01 00
>
>  cmd_rep    report_id   0x04
>             id          0x00
>             cmd         0xa0
>             sub_cmd     0x02
>             device_type 0x03 (left controller)
>
>  data[0]    0x01 (gyro)
>  data[1]    0x02 (failure)
>  data[2=2E=2E3] 0x0001 (reason, little-endian)
>
>Reading data[0] as the status would report this failure as success=2E
>
>Therefore I lean towards keeping it as is=2E

 Okay, Sounds good=2E

Thanks,
Derek

>Thanks,
>Aditya

