Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC962D7393
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665215; cv=none; b=dt+RXan/PwSd04btvDqGkrTL+w8nvJ88DBQkXd9W+Fzj/IoEYPEoxyYVK7uiCWU69kaLLBN6yzkf91I78Bo2T7pu4MpLSM+Am1zOj1T909wOvOdzbDapKnUvcko7Bic4xs4Ex6XisqnZD821ElrOLTXn/Q9qw6TfTsRiphdRgR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665215; c=relaxed/simple;
	bh=MjYdBZ+KhPzdgVMG0bXdHIPbo2KyirXZvHxMLywGyQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiUg8XMvrfzDdua08a8d1SUzG2h+l185+UsRlf8O63Bg4g/rx66lX8vPYceeHbCP9jYppoCEdELbnAQzeeQl4l5BPeNBj4FuWBrsbipRz7QLD6MlClUO0rOsGSUQ3VXRrzo+1KD9h1sQ7EzwkF5evN/fBFZD39VnD47ozBt+W3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hmp6ujtU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hmp6ujtU"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so18085305e9.1
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782665213; x=1783270013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guQ0P+X3jnAXfBbJ+Y3HO6eqQ362z84GunH538h30Ko=;
        b=Hmp6ujtUlr6x9NyJhxDWF8AgkO4aID97KWDWGPpp7Ps59FFCJH66nC0j4Q55AnsCm0
         /z46h+L+yrvB8quK6kmHn8GR2WPjxhmRFD32wZsypQC+fj05joDgDU81HjNqgCj0RDRa
         v8MdRz5LJcEZxhYoEfO5mBpluVEdrqKuglV2nOXGzguHgBOddcmVaClCVwY7bkYwlaes
         JYXzAo8RcCBSx5oudSkGHcvPMovR5hwI/k/lHfDrneSFLNEDwWjbKjb9ooCaNRncpTkY
         3f4Uvne1g7lsmM6sSi/f832pbeaxGE6hQHJilM5Ely91MIbDJS/fPitqn/bw/EslQqPf
         WXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782665213; x=1783270013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=guQ0P+X3jnAXfBbJ+Y3HO6eqQ362z84GunH538h30Ko=;
        b=pWNqWXN+iA/R5KWitiLR1Ji/+l3VyZjElQv5rfMpq6co7vs0o8xJYEszKSPQi3Kka5
         6NO+Dw7CRQfKS0NYFXAdo2ZOzlWMlmj4DMuKqEkZe8TE+M62+/nX0Dkhd2sybs6Gcmpz
         jdUAwsUz9UnTa+D0AJXmX+9PpTm7iaLKy7ajFtcODVFhFh9rK2a4WYPrm2knml080dU0
         86k0Pt73oONQDKCmkjm+Yp3DGfgoBiTlpeJedbjqQfc7lZfTrO75t2HlYTCLnuo5I3Cp
         UpvGwQl7BdAK5knzOd74IlVWju9XZXNjKXAw5UYJ3g1vRAMXKJZyjU+q9X4+14HUUKuH
         jPOA==
X-Gm-Message-State: AOJu0YwwU20KK+FEYXN+z2Dk3eYnLE6w6I6unKf5qeEWJ9P4mfM2HKYY
	GXZemcsabu1lPT/o7lplKX8a/1/Im8M0/RfV1jStnhw+CkJMUN5015r3
X-Gm-Gg: AfdE7cl1+TfXaEp7p9ESN2njx+sXZQhIygCW9k2FVCo9g3gof3U/ZprRzxgs0eZQFUG
	ZS/kvKW767vB8Vna7DQiPqYboWNjEjeaGqLdWB8Rb0dwEXiSvLmIywWavU9wNkDOKXQbTb8CR32
	hjiUjoh7ax3XUSBUDwdE1mQot8cSvm4/pWTy32Pgc6fsXUGZl0QVHRsQhxwxnT0k3MaZ1KfzfNp
	PawKlG4Hzf9Wz7bH2lddAyph77ERsGDtN5hDLR8fMl5p9wqxRzln/RLgKdG3GYJzL31mYndvgfW
	t15RlpqygRiXgrBv3xP8x8ffouLa0bKyf+arc+PF7aTsBW7v3+rtr0kuytXqdl/Hbk1HvAWhmSC
	yIOlVAOxW4itIJ1S4VYif3GkMiOHB0BdKCuMU83zCfaFv3QhE3PPovHXUc4nzjuYsAaf2p8cRL9
	WPb7RbIBeHWvi5sC8c3uPP7UWViw==
X-Received: by 2002:a05:600c:4512:b0:492:53e2:7712 with SMTP id 5b1f17b1804b1-492668856fdmr223520725e9.21.1782665212650;
        Sun, 28 Jun 2026 09:46:52 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c285fc1sm162770715e9.1.2026.06.28.09.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:46:51 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 3/6] HID: roccat-pyra: reject short button reports
Date: Sun, 28 Jun 2026 18:46:08 +0200
Message-ID: <20260628164611.17467-3-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628164611.17467-1-alhouseenyousef@gmail.com>
References: <20260628164611.17467-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Pyra raw-event path treats every button report as a complete
five-byte structure. A malformed USB device can send a shorter report
and make profile tracking or character-device event construction read
beyond the received input buffer.

Ignore incomplete button reports before calling either helper.

Fixes: cb7cf3da0daa ("HID: roccat: add driver for Roccat Pyra mouse")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-roccat-pyra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 0d515995bb9d..df8949c17ce3 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -557,6 +557,10 @@ static int pyra_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (pyra == NULL)
 		return 0;
 
+	if (data[0] == PYRA_MOUSE_REPORT_NUMBER_BUTTON &&
+	    size < sizeof(struct pyra_mouse_event_button))
+		return 0;
+
 	pyra_keep_values_up_to_date(pyra, data);
 
 	if (pyra->roccat_claimed)
-- 
2.54.0

