Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047815;
	b=KPxcozjljzA97a0JNaIjqxRkep9UNhsiObRSRI7NWdhCRVeTtsVszqKO/qXeBbsKUcIz
	 /9SnHlJdbrroMz7zpgHsGehhRR4oxauHNs4aA0U3DaS2Uhm376WHDLeFsk5k+sf82oG1I
	 yAOrKp7nhKbadYsUI5lKSuFih2Pvk3J3EBOGHCvj+VJsFkP31ECQiseJCt7kivFK5FeKI
	 rVBu2ocFMAZeKVsrw9IFVHR1Gk7O4Yh0MZO/OFGJg/XYhYILoGWuyB3wLtZHcB05J9xNz
	 /6ENhjcxCqEfnIyo/YNpVyHj2WwyrbopU7ai/N340nkgdbLY09tDch4jBk0tYpMT/VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1oiBZxzIQ5ApPwvupFbx80Jl2NVPJdhtgfzXDJp+rts=;
	b=sQ9M279ASS1eSUedqeLlZhIkLCVfLhjG8o0WP/lGXaClc1TFWsjDSqdrkY+5caLx4OXp
	 KV0R3R341SplidvFONHbwAP0XwRiFqB7qWw+DVRcEMnc3UpFWn+AwJtUTMjZPt1Wxs5X6
	 ZOHYRXbkVoWycXYkOosbFYQhxzg+xVMb9Q7HN8RLCghBXViUWLTR51Cu58qpwg1DIBuSU
	 YaEEGq3GK5llcum5cEplJwOgYKSPtKWnax+cMV9heb7HKqLLtuNmZU9cu3xm7tDeaf31T
	 UaYWqCHo+fjkBZ6ofPZakWuDqiboY6sGcZwWgjCGyAPwiKw6PJQsN103oWMhDyVlrKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zx2o+D7E;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5383E606A330
	for <linux-input@vger.kernel.org>; Sat,  7 Nov 2026 10:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5383E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zx2o+D7E
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a215e64962so15907765e9.1
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2026 02:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794047814; x=1794652614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1oiBZxzIQ5ApPwvupFbx80Jl2NVPJdhtgfzXDJp+rts=;
        b=zx2o+D7E096nEk1R0oFi5S9dE5tnH+trdZ/fJERPVfmF2gjz82jMM7SgxkyhvBh3+9
         6B74ahGQmhPfTUn4KJXMGAlli0S9ld6+u2i3tLTK7yz7neDSJ1GMOCprM+k/iY2u7qIW
         /GN5rRG3r4+vS4gAclriM8hzY4i3wPSjO9mxTxUfm9tfr4Diju2WJ4axyU8R9T96k8Vr
         /4WLYnresYQMK+Z3PLncnxrWoKDdYTr4PuPF4etRU8tDhGJQziVD+En/FOM0Ycw1LwgQ
         JkFG5yJumd3IfA254qVBJR4inUcyyyJsT6H+YeTbbereMJGMPjpjlxzzfap/OBXD5EGn
         ccGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794047814; x=1794652614;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1oiBZxzIQ5ApPwvupFbx80Jl2NVPJdhtgfzXDJp+rts=;
        b=Ewzci7DyahW41BkQhQiImvnwzQsDoLb+YGMDnMdPoORH8SXBnSJ4D5ofjgwEMn50z/
         /px3m5FHT6xWt/13Ck1cs8tZzySAekTWD8vwd1dDGqvvBT3FWh136PCZJweW1K/v7oQp
         uFMsnYShiLg5/SnZBPaFS1RhfT4kSqdj+6fwho/MsFdx9zkGwaK+1XKmPuWUX3zbB1or
         dCcno8DaOMMWpsiEfMw+E06sASTreFoJnKhIaKlL8+Tn3hhpkXXTSeMTgx2BToSS+rr6
         Pz8v1CVTYnKvpKLtao/uwW7cL+28uINtFpRd95iE3wNNgTRDJg1zKtCWRV1Ndoftx/Nz
         g+Vw==
X-Forwarded-Encrypted: i=1; AKwUvBzVuceYpy0C0lvj95aNsy6Kf66z8hTkbRxtpXOOkwD4Qz8DTUJN4j8p5iCpKKViqu2DUcMqitdHq4PW8Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8+9XVtZJIDVRfMEzHiiPBGcrP6oLf5d94TNJ70fkMSN4XFSOjB
	FYdtxu8n42Du7fl0UifcS9AdBmoPRoDkYISz7Qx/B+sxaF1yRQdeXb1uKm3Ufw==
X-Gm-Gg: AYBFou0pMXEZbe7YnoS8KByB1mH+x810CV/Qmh71j7ntX4NDxJq0/ikDOdQt5/S5+CE
	d0N7j4ZCsGlSTmVqkCOlVzJJztg0o3nxmrnL3qwdsLXfi05l5slmDuvC0iwnCzAFz8eO7gkQ4d/
	exsIjoOvy5V3W5eS/vdQMnuayn1+0sia1yuy/xhzQv/WgHPRyFf7MZfdlZLWe8o1H6eDOh2jsBs
	N74jcbY3i7kNVhNno/w0EcPvky+xhcmuFKGn/peNLTXsZcW9L+Eec6w0JjWZ1HhjimX6jN0LOMw
	1ktKlFPB6+DWdIhldt88HjUy2eVNlhpBxAp39FsvZi1K7vsd/FwmVert6J8S7IaZaJ4mCNdhnvQ
	ipdLv66nrHqxigxHdCXjSyrAo+ELfCbx3cIKnGGHc7kxH59AMBKwgvSQwpoHErm50Gx3d+eTgd3
	Ag1jqPZpKza7ydWxF/dcxSjJqLadfrxK7OwENV6IRRE/WcYpQL0TdmPMagtU36DsgodqqKTuZmR
	vKizDxReeQfMv+0aWRMm7jMVE7bHI2bioUYiIMSlkP+b+dr3xtdSu5Cg1m7OxhHWfrQlS2O1qRZ
	us6gM5Xzlk3H5JnN+vgQ9e5PEPhzSiHkbiAlBv6xSh8HyJ421bCrdB8Mkp+KEVDsnFaeF+n/Qbl
	VHg1DTgL/C3CIkrEtAZOb
X-Received: by 2002:a05:600c:a013:b0:4a1:c6fd:4db0 with SMTP id 5b1f17b1804b1-4b6df5eabebmr88206095e9.19.1794047813611;
        Sat, 07 Nov 2026 02:36:53 -0800 (PST)
Received: from meven-thinkpad.home (2a01cb088745e00090de407b41070a01.ipv6.abo.wanadoo.fr. [2a01:cb08:8745:e000:90de:407b:4107:a01])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b795038782sm42289845e9.3.2026.11.07.02.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:36:53 -0800 (PST)
From: "=?UTF-8?q?M=C3=A9ven=20Car?=" <meven29@gmail.com>
X-Google-Original-From: =?UTF-8?q?M=C3=A9ven=20Car?= <meven@kde.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] HID: logitech-headset: add a battery driver for the PRO X 2
Date: Sat,  7 Nov 2026 11:36:35 +0100
Message-ID: <20261107103647.1196629-1-meven@kde.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <V4-MESSAGE-ID>
References: <V4-MESSAGE-ID>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

For anyone who owns this headset and wants to test v4 before it is merged,
the same driver is available as a DKMS module:

  https://github.com/meven/hid-logitech-headset

The source is the v4 patch, with the two USB ids defined in the file
because hid-ids.h is not available out of tree. On Arch Linux it is also
in the AUR as hid-logitech-headset.

The repository also carries the udev hwdb entry that makes UPower see
the device as a headset, which is proposed to systemd separately:

  https://github.com/systemd/systemd/pull/43737

Test reports are welcome, here or as GitHub issues. A Tested-by on this
thread would help the patch.

The G522 LIGHTSPEED (046d:0b18) answers on the same vendor page with a
different frame layout, so it could be a second table entry in a
follow-up patch. Nobody has run that on real hardware yet, so the README
asks G522 owners for the report descriptor and a few replies:

  https://github.com/meven/hid-logitech-headset#g522-lightspeed-owners-wanted

Regards,
Méven
