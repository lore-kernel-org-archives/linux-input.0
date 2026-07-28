Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEFE466B1D
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785264002; cv=none; b=DCzOw6ZsggFtWv9Y196kSlXVVzI9fSmecaS3Mw1kW7i55BRmjnKiqcmZ2cDoKULzewlSDkjUz85qXJQoIum33d9XvQCaMmd0ge57xnfKuSLbRHXxwJiLbnKO73RI8sJKfu9dPkzGNbFLoH9E6y4GBr6Jvd97MvWBL6epTjd4X2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785264002; c=relaxed/simple;
	bh=wmgqjAU8LGLuTBGTqgtzum73+chcg63x9G/qkZbkq50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6xjKU5uhngpLtvKyEbHtLsd1unp3zngNYNhepzuWGpG1lTbEIEZNytDb20H645gS5bWJjCiiAXBlYn6tiicftOivFkWS1Y32KGwk6UuFmWebnx71cqVD/4C9e0hWXpY9WSFGmDKqAmdiAN8Q5dkjDJjeBEr9RBdW7eXMpurk88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+a8sfvA; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+a8sfvA"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6ab05b2f9daso95341eaf.2
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785264000; x=1785868800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xkf9XQPSfNEqYu/lK1cOdYxG0oWwY1T1NURcZl6XkKk=;
        b=I+a8sfvAJSC49dT8agF9dHd+aX069jzRgNcQXqlQeVU23Ce1cNYADLGFW6qK8AILeb
         tYhmlXxhhByAtYwIiv9kWXjlRUPGViXkzO/MYEl4jpBGZo50ceTLuKkRpdG+8cWfPlHm
         J16iHGmsUUnnT0T3GRkhKEaGvbVD0wVLpOPMFYcm7zgY0z6kDa/Zu/y4lU0L9to7Zpm1
         gs4Xaw55oGuDv5vmH8bd8VSmkSaxnwRL6zerFHzfYuofz5ST8fLUfwR52nFYZTZTF4BF
         dVIgrITmJFmaQeXLrBUnnDeXwHBjP1QBnrxEc73marbmCFFOLkto22X6N4i4jIcapmVq
         1TGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785264000; x=1785868800;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xkf9XQPSfNEqYu/lK1cOdYxG0oWwY1T1NURcZl6XkKk=;
        b=WHDSbTkZw5w1oRr5oAmRNjyAIIieCjNkw9LIRgxiMhSY0HGhSisQC4ldk8LTEMypms
         P8ZilV9q8Y3wJAtJDAcr9SKPgihSav35s7AIGVYD4u0Ud7hYTyT7W6R8tyziMix/YpLR
         5658rgCMkwgWR1tsX4DnxSLL+tRzNn0FB9xKFZlPKiNzQf2T0nspKR0lAcvHJfk9T2k4
         GAulS//5exa+AswKIqBh+yjgc7PDQyWHNB9SxfRCXLSJchpiO8QJj8Kxy7XchtaiDvQn
         Ihv5vdRo4dlpApr0qk1BeylYZBh+Xa2tEzAxhSNSqArvX0HVexir/AYp8OdZ1nTCNInt
         oIXQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPxQUieqyoRc167Frgf5yz+WRr7WP09ZVj5raZELPrnOPBoRm8HjSfbjFf1pig0uU/j+Ove0oRwXqHbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh1sjXgvFaYLSQTPtybd1Pn7ty3dAMjqZj+CobuzHX+z8kiiBI
	ricuQcWgBrrpDO+Y42BlBULng65B7fCsWpXcdID824trmbTed16Ra5zm
X-Gm-Gg: AR+sD10NEd+NHhhEbUDO5yySY7z7mBJSroKk3Lkj9D0tlaSf3VkI7nfrW8YaUZ/oOoV
	GEYr7NIIz1QRljXEdosnkBE2hDTzXk6dP1lc15IUhWML9zRLNIgH558BuIPcQKCv96CRDm/ZNTT
	wQKoQwfRB86+xBbzoPHps41IBxE87omPcGypJNWOayJEBXJbEiM4tOUgjBDk9VyR6tnmb1ZZ1EB
	z4Lsg7H1v/ZjFxd67cYkwq5vZTOah1SRPkSUEjyWM2+pLkxs01+nOleWlgzskN7eTzmfbZZhDE+
	RzQWnM56jW6OlDa1nn/gRjcqAsFhCyzi6pY/ufJYRe7G4Abwii2LBkn/RWgIeCmYPsWS/Vk5BFj
	UVFBhLjDyCbTj0D5QLbE5ScHtkW6t2XOxqLNDSFFAallX1OCwB4XPzklo24mgjziCxy67KB1jpe
	9o1A==
X-Received: by 2002:a05:6820:4b8d:b0:6aa:fc2b:eb04 with SMTP id 006d021491bc7-6ac96c4160emr1775325eaf.50.1785263999873;
        Tue, 28 Jul 2026 11:39:59 -0700 (PDT)
Received: from desktop ([2806:107e:1a:2f14:d204:ec3e:fc64:563b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d8d397asm381363a34.17.2026.07.28.11.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 11:39:59 -0700 (PDT)
From: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
To: Alec Hall <signshop.alec@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
Subject: Re: [PATCH] HID: magicmouse: reject devices that bind without an input device
Date: Tue, 28 Jul 2026 12:37:46 -0600
Message-ID: <20260728183746.685507-1-pepemontfort@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728072554.47069-1-signshop.alec@gmail.com>
References: <20260715195853.1302765-1-pepemontfort@gmail.com> <20260728072554.47069-1-signshop.alec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 28, 2026, Alec Hall wrote:
> The second half of that turns out not to hold on real hardware. A USB
> Magic Trackpad 2 exposes four HID interfaces, and only the first two
> register an input; interfaces 2 and 3 are vendor-defined, hiddev/hidraw
> only.

Thanks for putting it on hardware. You're right, and the stable argument
settles it -- unbinding two interfaces of a healthy device is not
something to ship as a fix. v1 is dropped.

I can confirm the same shape on the other model. A USB-C Magic Trackpad
(05ac:0324) on an unpatched 7.1.5 here exposes three HID interfaces
rather than four, all three bound to magicmouse:

  0003:05AC:0324.0006  input=input12  hidraw=hidraw5
  0003:05AC:0324.0007  input=input13  hidraw=hidraw6
  0003:05AC:0324.0008  input=<none>   hidraw=hidraw7

Interface 2 is the vendor-defined one (bInterfaceSubClass 0,
bInterfaceProtocol 0, two endpoints) and has no input device. So the
interface count varies by model, but an input-less interface bound to
this driver is plain normal.

One thing worth adding to the picture: those interfaces do not merely
bind with msc->input == NULL, they can also reach the dereference.
hid_process_event() calls ->event without checking HID_CLAIMED_INPUT:

	if (hdrv && hdrv->event && hid_match_usage(hid, usage)) {
		ret = hdrv->event(hid, field, usage, value);
		...
	}

	if (hid->claimed & HID_CLAIMED_INPUT)
		hidinput_hid_event(hid, field, usage, value);

and hid_match_usage() returns 1 for everything here, since magicmouse
declares no usage_table. So an input report on interface 2 or 3 walks
into magicmouse_event(), which dereferences msc->input->id.product right
at the top; ->raw_event is called for every report regardless. The NULL
deref is therefore reachable on genuine hardware, not only on a device
spoofing an Apple VID/PID -- a better justification than the one I sent,
so thanks for that as well.

v2 with the per-callback guards follows shortly. Both callbacks return 0,
so those reports keep flowing through the generic HID paths exactly as
they do today, and magicmouse_probe() is left alone. I've credited the
change of approach to you with Suggested-by.

The offer to re-test over USB and Bluetooth is very welcome, thank you.

Jose
