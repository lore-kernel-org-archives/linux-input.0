Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB60346E70
	for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515829; cv=none; b=Mldv83BrW5O1er9nISfVvrcuBgtBcvMUYMe4eoIvjt4foflumx/f7Ie/1z+nLqId1jG9UzawpWkZ2viiEVVoedjCbg/i5PnimpzJouhAczk9IXzlAZ35JN4KA5is7YvL94GNSuFTziEIA/WmlThfdnhaU5gTNBgrsPANYOQ0BuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515829; c=relaxed/simple;
	bh=yNwLklFgEsd/71GG4AgwLwAO0rS2VcvNhtibRM3aU8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FyrDPkkjUXFCipwy7nVWLmyKo9v3ykyXTmGRCypK4q28kYBAas0QV9XlZlBx9YLh3uEeyJpPk70tdW0AM5vLF7HjsvZNPlNdlwyWbBCA46KWHnmMJ3yGX7Gnmz0xwRZFPsgzKFldg6apFQq9k1u510ks7kfuE92b/7E5Pet6rd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+fVbb7G; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+fVbb7G"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4836bf1a920so12525165e9.3
        for <linux-input@vger.kernel.org>; Thu, 19 Feb 2026 07:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771515827; x=1772120627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ww1BEiMaHLfYZUa/3tnTdN6593kM77ve8/k6LvZ/MCY=;
        b=G+fVbb7GnOAJqZPP2PLafR5DqEBMMRAGku+Od65HqsGTQoq0Hl0z2fnD7WfK+YKKoq
         tzGLbQllqXGucc/Z+GL+NMm1SVhcdhqfWZob5JvLPAuOAm08/DaW+Mts+CsU/7vo+w+c
         nd+KmAB/cXwqDA9yuubgbvFzcp6xaLRCD4g7lyBdqPbuQFWfR0qGN05HPcJYRwE+XMJC
         sbg4mBvxGaorHnh2008Wvf4zcb2fi6ri4Jri6H+8S9DJdrMdBdYtca9sNA2InnZC98pj
         hMLIyyuoPrzwL1tjjOCZo6FNkGbLPYC9dCMhfgvTl8O4UtoeW8wnKoesqQQVPCjIEwcW
         rdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771515827; x=1772120627;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ww1BEiMaHLfYZUa/3tnTdN6593kM77ve8/k6LvZ/MCY=;
        b=Rqv2CHFOY+y8HCE4bijukUsSO+XYzjthMN9KLbpFABy+uOP+9LeyjkQ9BDnvpNgiBt
         x8B0Yd0COmRogk8CROuCK1kNTHyKGmZRIDTmsgJDzXnsCk0/kmSn4wyO6eqwIXphPe+i
         /kNBQHujTz3iAnD9wLKxmTBeJqOApqQHJCJ5jRLrUrDAJHWMWtWPQJocF5cE5eFKresz
         Q2Vml5FYUK7lDlLBjquQZjreV7keoPtY70v7IoVoBluYM46uBkgrMmK48ZjDUvHIFI/z
         7VJ+HqgYRa+vYZFoyVtSumcyGY6ikdqw5U+yHfTs7T+Pa8CxnkM7H4ZbnWB05ManacuJ
         7yNA==
X-Gm-Message-State: AOJu0YzSx1CoRmjjiI5uJ4e7kaK6Oq8jA7zIp7s4iV/h4MA8ZqF3F8M9
	7VhiUwK34WKxcI321zaE+rn4JKNvv0O4GOZgcV6SItZchV+em+neUMK1OgZg2LsA+ozsrR7L44l
	Fj6R14g==
X-Received: from wmos16.prod.google.com ([2002:a05:600c:45d0:b0:477:a181:1922])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:698c:b0:477:5ad9:6df1
 with SMTP id 5b1f17b1804b1-48379b932b7mr332791135e9.3.1771515826700; Thu, 19
 Feb 2026 07:43:46 -0800 (PST)
Date: Thu, 19 Feb 2026 16:43:36 +0100
In-Reply-To: <20260219154338.786625-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219154338.786625-1-gnoack@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260219154338.786625-3-gnoack@google.com>
Subject: [PATCH v2 2/4] HID: apple: avoid memory leak in apple_report_fixup()
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The apple_report_fixup() function was returning a
newly kmemdup()-allocated buffer, but never freeing it.

The caller of report_fixup() does not take ownership of the returned
pointer, but it *is* permitted to return a sub-portion of the input
rdesc, whose lifetime is managed by the caller.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 drivers/hid/hid-apple.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 233e367cce1d..894adc23367b 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -686,9 +686,7 @@ static const __u8 *apple_report_fixup(struct hid_device=
 *hdev, __u8 *rdesc,
 		hid_info(hdev,
 			 "fixing up Magic Keyboard battery report descriptor\n");
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

