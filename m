Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F203933D51A
	for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790447886; cv=none; b=Ub037AcPOzTUl2tM2JKFk3kAHyaIhZSvCC4uFRXlGicPn0/K1bKkixD8Z8T1F2VRC6l4rdxmwr5OH0odk+b9caVpCZ5tfZD+ZKEyJbaHbIZG5e7U86BvH10yXKPtOIm3TSSFQbDZWw//bfTNz5X8nT1mt4bVs/b38zqQhSxYbyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790447886; c=relaxed/simple;
	bh=MjR9f5NoOpd2UaB4XR935SG4yKAkwURqh5Ir7DGq2js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4bgYUzCmpmTP3msamgnVRlsm2VRsX4Q6+7YMSWGLv24PDYLDR3zF91/xpUTzIil8KkNJGliKXCCeeQbQt3E3lRWaLvKPSrqgrXDkq73eksc205OWT+sQ08n9PuhXUHHkX1Dx0qbpQekg8yfz+9uoHYkRq0Ho6ZrYB8f/MHXoxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/W2veP4; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/W2veP4"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1279314a91.0
        for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790447881; x=1791052681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d1XUqqZiqb1qQXuql8X0BjOj5vyi7AUzXY8wnAT+llc=;
        b=R/W2veP4mzySdhsOnD0yds2gON7IT7lgnSOtYBBcJ21NG90/GMJXUEDrZ8+mxNYWn/
         C9DjoGHTcot99i8bCDQQuGDUdltS0wciPA82mVFJBh8tKLB/+9Dnxr7B/bXhwD6db7bW
         YdnbdI5HRd/nEeMw6sp+OORE+aBVfQIGAjyGUNJq8OBp4g/i7GSb9umD9Y53Au1gusBF
         PSgjQCr7gD5h7mw+8Ro0nMhJYypTD4iVZWEdvYxq77T9/Uk0ZtpBnjeqX2kI+frEeRy+
         4q9HgDVa7OBEVoJssugoJX2mXFVICMn7WMKO9F9/VLsPSCCV6oIbl2JUGZpYdzgjVb5h
         sLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790447881; x=1791052681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d1XUqqZiqb1qQXuql8X0BjOj5vyi7AUzXY8wnAT+llc=;
        b=1zhd2zO5XPSGQC3Lh76pdJ1STVkAlgx8OQsJcOWku+NTy4g2/rWR4cS6ypnTEBCEJE
         7i6P4y61Xmyjgp33FVqV8fyTcTxdkvJuk2F9kqufFieu695hzGRJJxMd5wswKEShlpeV
         EUb+EX634lBpFhwsL+kLegu1AWf9J80UPpF9bds3D9G8roZ3eqkuCEGh/rPEV2ftNSuT
         Rw0mm6/odpAah3ZotZwsuJ1WeAms8Xhzrd9qT8nNAqDjNZ5WSBvtLlFcAeFV/ZJAXOXd
         JKc3Zh6PP3sB723DUqT53WFoJwZ6CdnIDCR1aKvC8vVrGK9Lu1bj+7f2vf2jJpboVwJF
         0sIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkeYzljzpGKA+70ENk9X4XRK6DZ6o78Nv05NoBpVtJoVoLAphoOMwMSkMFe+R1ENgMxPletPl+3VImEw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJpaxEHYeOvrc7XZyDCX3V3N8GezyVmBVVL263Ml3JCtxz0gumm
	zDyKmC5qxXdj3saNoOZgVudCB/bBByKUHwX25sQrgVPQKuJKKjeL592/
X-Gm-Gg: AYBFou0Naqn/NdLP5Kytcrt1tLXKCVL+Av2U3FCvIFYBpSjmumvOL+EXarapH3KKJ0l
	0Vb6ZK8nQAMdOyAqQi0SZ0RgmCaVcLn5+y3wMohd9BNDc0BnxG+ScvC4Ln+ucUFI+ACWES9GblI
	gMDyfgxY8l/03XMhRVKF6iKBj8XygZJQwSmRrzgBgU93tnUhnluLy8/BCGJuinN01TfvI9Op5mq
	rTahfezzfIEqJ/4qKLNhSgDs1T0XnCSfLaLLe9L/rgOUzJ+xh8iOK18/ST+LA8F/JkuLPNoZDWD
	/eDzLBc/JEZx6bvkH1l4uMVUXWfeTnVYBskZAPK9okZM+6PPnQ+Brc1bjPBNb8FV3W8HO5BWWRB
	Src4IeLMlgb3bRNqW+Ps8YWMi8/XDxIkDaLi919ylMiL5A+1+VUXBNz5ctA1DukRmKHIf3OOg/9
	Qw0afyz1mrn9gzkrdgIDYAOPLYb8xg49/bNBBR4lXgxNl6E3EiUEKKmYalQQCA0f5CtXdIpX7M1
	Oa8F3/h8OygHyYO+3qjBXpwnMmEiBWapg==
X-Received: by 2002:a17:90b:1c92:b0:39e:6c68:c77d with SMTP id 98e67ed59e1d1-3a098e0515cmr8310824a91.51.1790447881043;
        Sat, 26 Sep 2026 11:38:01 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9355e49sm10939486a91.4.2026.09.26.11.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 11:38:00 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jinmo Yang <jinmo44.yang@gmail.com>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom: fix NULL pointer dereference in wacom_intuos_pad()
Date: Sun, 27 Sep 2026 03:37:57 +0900
Message-ID: <20260926183757.3347378-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet>
References: <20260523150101.611473-1-jinmo44.yang@gmail.com> <20260523150619.615565-1-jinmo44.yang@gmail.com> <ahoH87pet5BUQwfD@google.com> <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Jun 2026, Jiri Kosina wrote:
> Jinmo, are you planning to submit extended version of the patch, please?

Yes - sorry for the long delay. Dmitry's observation turned out to be
broader than pad_input, so I audited the whole driver before replying.

The check already exists in three places, just not everywhere:

  wacom_wac.c:1807/1815  wacom_tpc_irq                  pen, touch
  wacom_wac.c:1210       wacom_intuos_bt_process_data    pad
  wacom_wac.c:2192       wacom_wac_pad_event             (HID_GENERIC)

so the inconsistency is inside the legacy dispatch. The clearest case is
two adjacent lines in wacom_intuos_bt_process_data(), one checked and
one not:

	input_sync(wacom->pen_input);		/* :1209 */
	if (wacom->pad_input)			/* :1210 */
		input_sync(wacom->pad_input);

The pointers can be NULL on a fully successful probe: the handler is
chosen by features.type from the id table (wacom_sys.c:2945), while the
input devices are allocated from what the descriptor declares. When
wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
wacom_setup_inputs() frees that input, NULLs the pointer and still
returns 0 (wacom_sys.c:2172-2196) - "no pen in use on this interface".
wacom_wac_irq() then still routes reports to a handler that dereferences
it. No error injection is needed; a descriptor declaring only touch
usages is enough.

15 locations, each reproduced as a KASAN NULL-pointer dereference on
linux-next 20260925, x86_64, from one /dev/uhid device plus a single
UHID_INPUT2 write:

  wacom_wac.c:137    wacom_penpartner_irq            pen_input
  wacom_wac.c:227    wacom_pl_irq                    pen_input
  wacom_wac.c:244    wacom_ptu_irq                   pen_input
  wacom_wac.c:303    wacom_dtus_irq                  pad_input
  wacom_wac.c:326    wacom_dtus_irq                  pen_input
  wacom_wac.c:391    wacom_graphire_irq              pen_input
  wacom_wac.c:444    wacom_graphire_irq              pad_input
  wacom_wac.c:594    wacom_intuos_pad                pad_input
  wacom_wac.c:1209   wacom_intuos_bt_process_data    pen_input
  wacom_wac.c:1232   wacom_intuos_bt_irq            pen_input (dev_warn)
  wacom_wac.c:3100   wacom_bpt_touch                 touch_input
  wacom_wac.c:3117   wacom_bpt_touch                 pad_input
  wacom_wac.c:3130   wacom_bpt3_touch_msg            touch_input
  wacom_wac.c:3178   wacom_bpt3_button_msg           pad_input
  wacom_wac.c:4229   wacom_report_numbered_buttons   pad_input

Jason, your review of my earlier series ("HID: wacom: add report length
validation in irq handlers", 17 May) asked for the length checks to move
into the sub-functions with len passed in, plus WACOM_PKGLEN_* names.
Eight handlers already take len and eight do not, and six of those eight
are also on the list above - so I would like to fold the two together
and do one edit per handler: take len, use a named constant, and check
the input device in the same place.

On the shape of the fix: I plan to put a check where each pointer is
taken, as wacom_tpc_irq() already does. A per-features.type table of
required inputs would be one place instead of ~15, but a handler's needs
vary by report id - wacom_graphire_irq() takes pen_input on one branch
and pad_input on another - so the mask would have to demand every input
the handler might touch, and would then reject reports that work today
on a pen-only interface, which the "no pen in use on this interface"
case says is legitimate. Say the word if you would rather have that
anyway.

I will post it as a series split by device family shortly, with the
shared helpers (wacom_report_numbered_buttons(),
wacom_wac_finger_count_touches()) guarded once each, since several
handlers converge on them.

Thanks,
Jinmo
