Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5BF34887B
	for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515832; cv=none; b=Nbsgh6fALw5JLQjNAllUGXCBnDYTVGzzD2ttWHV5ODCqj0VPjjafwM/anaOWcikhYz1sO6C+x3PYAFlsMiKjgTbw7or5P0oVJ4s2URA+j0CUhT0WXEDAk7844cLz9CRP9O+0ZV6w4S5J6Q2SDtwbHDp+GmwtMcrd5RTL+aIQPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515832; c=relaxed/simple;
	bh=L3lZgJogZtRo+hrmpb9U1UPAKGerds0qMe0Up81PuIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=htP0AOGFZg14zH9Gys2qSaOD/tsqzAzgGo4GtteQyCWzmrV4nhaDWUpncRk8vfNqs6tvnXhTbaidrYomg/+FHlWk2A4wBgOFdsbQZ6yF7bQKaqhFs7z7znzVuHXf6w/W0jWrqom3Xb8XZeKa4ljopIom9s9lul1T8vWlAW9XLr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bkXnnY3R; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bkXnnY3R"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4832c4621c2so12416925e9.3
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 07:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771515829; x=1772120629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hyc0hh7Bv1PMxa3L5KyyOW4WOvgP8JpSIAxvqyUwZoc=;
        b=bkXnnY3R7wa2h+9ve/KZpE5j5fcrl22Oe/rO3ymln+dFTi1ZfjQNdlrmV+Hzcmkqu9
         AHZppFB8QvwHWeCcNUa0V/z8pv5rnADPSb4Y8G7+HhSeIAOncEVb/vlCLqd/49RaRK+2
         lbm/Pnag9/6ZHN2iWgDcVOF93SXeKyaycB56CNMlFFD87pE0CTO8DV/qL0URwLtenrWA
         ide7TIej6Swb7jql7KmW0GjQ0J+TNyLVZkcAfM6Pqf40pcugptU8aONyZFRXt8o4/vfh
         xIqIAUglNRfU+6KSmwnXKQYauG+ezyt5JuQ71y/JoWHA3NZjUURGn/ExIHVky+LfRSrU
         MvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771515829; x=1772120629;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hyc0hh7Bv1PMxa3L5KyyOW4WOvgP8JpSIAxvqyUwZoc=;
        b=r7nW2r7WoBmW+KGuOxjYQt9ITHLcqqVvL706hMa+6GHDqIfI/Itgn4Wj8gZkzfTcLR
         YmUwr/4+1yM6osYxKz8Trr1VCxmCOSq+JZDt6tB4d3ZjPG4eM330U1KCudUhEhVllQ9d
         7BmRpq6yJlP7HUhf1DEsMsEFSHNE42jRaboi6eo9itUXct7HVqnnqDyCZJHf8AaC8cPV
         EBFsAntoAl1yIQKeaH7cTS0DUtVEkFe7AWC2EFW3/EQZPbLF/HQRQscayIlsXfp0iJbg
         A/WUK1pju4zOk2p8ZsmV4o0floFA6DDPl9L4mE0TpUwDw7Eb3m/vioO4Ljlz/oEmUO50
         rP2Q==
X-Gm-Message-State: AOJu0Ywe8Obj6eW6GpYfjlCTzgDG5oE1griHIL4T5fleWaDscnycEiRK
	I6yDjyHB02CMqUMEYsY7OcXVrpouGU6b8SJJeCWIWBAIdCANjZoVIPVdYRpWY0/0PEevYWewUj9
	WZ7cVAA==
X-Received: from wmjs18.prod.google.com ([2002:a7b:c392:0:b0:482:dff5:2424])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:314f:b0:483:6fe1:c057
 with SMTP id 5b1f17b1804b1-48373a3f3bcmr344540285e9.21.1771515829387; Thu, 19
 Feb 2026 07:43:49 -0800 (PST)
Date: Thu, 19 Feb 2026 16:43:37 +0100
In-Reply-To: <20260219154338.786625-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219154338.786625-1-gnoack@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260219154338.786625-4-gnoack@google.com>
Subject: [PATCH v2 3/4] HID: magicmouse: avoid memory leak in magicmouse_report_fixup()
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The magicmouse_report_fixup() function was returning a
newly kmemdup()-allocated buffer, but never freeing it.

The caller of report_fixup() does not take ownership of the returned
pointer, but it *is* permitted to return a sub-portion of the input
rdesc, whose lifetime is managed by the caller.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 drivers/hid/hid-magicmouse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 91f621ceb924..17908d52c027 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -994,9 +994,7 @@ static const __u8 *magicmouse_report_fixup(struct hid_d=
evice *hdev, __u8 *rdesc,
 		hid_info(hdev,
 			 "fixing up magicmouse battery report descriptor\n");
 		*rsize =3D *rsize - 1;
-		rdesc =3D kmemdup(rdesc + 1, *rsize, GFP_KERNEL);
-		if (!rdesc)
-			return NULL;
+		rdesc =3D rdesc + 1;
=20
 		rdesc[0] =3D 0x05;
 		rdesc[1] =3D 0x01;
--=20
2.53.0.371.g1d285c8824-goog

