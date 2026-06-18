Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6F1A6823
	for <linux-input@vger.kernel.org>; Thu, 18 Jun 2026 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781751642; cv=none; b=dou+Ystd7tIEm3eDZNifgUmrMkT8GGa3z4+8u/M1QEli4LaYpeZy/jybyqoozuUKBrjxUq9ZY85M5/+agzH29+a5klfJUvmrpO4gjy0wcF9chuxL22wLYDQhHnZaIukg7UOu2PU2qySwrPN5MkYfSs1IlqFYENcaru9mhi0tuoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781751642; c=relaxed/simple;
	bh=AfxbGindpSpNdPQTPeAWF2cMKbccAaiT7PPYpkoi+CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o5PLbLZu24aj+P70z7k0Tux+7QQ/9/Hjv85umc4t1avE9U9woBUB/tSz8kRyqu6HTZdtJjkFqvYKVDujx4TR8J9A/wmlzvNU5bl02LqfFDJF19j80uI2DAucDJgax42ca0eQyTHm531COuiWN/w0fZrrqZoLOLIUpyQPkaDparQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzzTXQWq; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzzTXQWq"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51758478240so2309421cf.2
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 20:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781751641; x=1782356441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PbqkhcnDy+fk3v8FG+ssEpIedLRgumUtUegBf6kSJac=;
        b=KzzTXQWqloZzpdtcaeRRDQ06jOcSW7xO8NQ38fDhHb5I6j47bWwsGZzIp+j71WhXEj
         gppwvFHGTfHEV/c372ur8jI8u/ByFQE6tFeN/tyT/HICLp0IzmgPXnaQmCAME5axIr0K
         Z9U55Q99ld31M3VhD89sjTrlpzchffu04P15BISw/kNFzTYie57iv5oLyNp8Ofbovekp
         yoxa0fSvFNoC3MjrmevySq6Ru43MEJRdYaIb0ARE6vse5gaun8Bt0J5yEr8u9smIFQbc
         g3jAvTj7sjnRzdNCAs57pbAqzXkytvJ98o2SIjqbB+DKNvG8vnHeuoMOApj2WRo2saok
         a76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781751641; x=1782356441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbqkhcnDy+fk3v8FG+ssEpIedLRgumUtUegBf6kSJac=;
        b=jTcl61S5Gh2Lz4I1y98ICf/bfcp04pMVUmSZ88giFEpUWG1Q+xdEdvUTmPYAcw761m
         0FjKyyWYeTazVz26vauZxVZ7VRLr9lNWH9405fJEYU2FZURIsU7z5iWK681epD+S3gPe
         hfr6ea+5c6uunPuRqho1khdQFpqFvknFbEMPthpFFio4lxViDs/oYBUPgomqwkoGVekJ
         ohdz/p2R0q3sJcgwliTsWVJ6TNJFTD5kjeQB0wra/aLjonu3jucaSyqVpHBw7h3nLiwK
         2kVBNuABLvpRwNr/aofsuqJL9aG0C17Xz2RPEFkOH6Wpo4Wg3VnuAon7RRgpN4F4VOsl
         RT1g==
X-Gm-Message-State: AOJu0YzHhADld25bxywGGQWs7sJkzbthcBKG7eitIABSOPmV/gQIG61g
	gOqsmaTsXuc5x2ux+iBeXsmdQNkfwGyOvMBg+JizmIFWC5dJi8fZDz5v
X-Gm-Gg: Acq92OFZPzcT3NwGM4evUoCIDRIKexw6T3dp83AY494q/NuAAjLw2hvg0a5eQMY+vms
	c/MlkoYO6qAQl04XEYW1FbHZKzMNPGoGMI/RvSJFRZTAvyvmOklCV15qdQPiblAYFqQzkLF8+SC
	JBRLibJSAmB+XuvOck5Hgud3qWv8JnGtf0SyGZnhoUzorRbEBdFLfyQa4Qk0bAq+jm+uVmJNxBW
	3487J8YvgF0RfcnicbObi9YMCahZoNUkQAOX+Dsq854nxVUIoNgtwoPfm7LB4T4WZE+1Ett3Bu7
	xHGzHR1SdRNG4zL8Uzd4YLEif7nmcYLNxABRCtxA6wa4BrzFo7xryEiamKOKCxOozYWMklQj8vO
	LPr7NFW5luhYHR8HDHwI9B9xcdUYwoljfzClCG8wi0GCbF0xEb3MPZvYApqw+m8nUjlFIW3lU77
	6E8u/+2Ozr0sshushHRQbd9+/TEbiqMqBfM4+zdjDwuoFvh758ApTmXyIInvpbJfmoBgubkFDHf
	+mFHayp2RY7NUtddS8NqXlxY4r60MhlrnOK73Zjl1U=
X-Received: by 2002:a05:622a:347:b0:517:e192:f896 with SMTP id d75a77b69052e-519a8e34fc4mr99993321cf.25.1781751640674;
        Wed, 17 Jun 2026 20:00:40 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61eaf4sm183849021cf.4.2026.06.17.20.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:00:40 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] HID: roccat: bound device-supplied profile index
Date: Wed, 17 Jun 2026 23:00:34 -0400
Message-ID: <20260618030036.1880139-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The Roccat Kone driver uses an 8-bit value taken straight from a USB HID
interrupt report as an index into a fixed 5-element profiles[] array,
without any range check. A malicious or counterfeit device that claims
the Roccat Kone VID/PID can send a "switch profile" report with an
out-of-range value and make the driver read out of bounds; the same
unbounded index is also reachable at probe time from a device-supplied
startup_profile field. The read result is stored in actual_dpi and
exposed to user space through the actual_dpi sysfs attribute.

Michael Bommarito (2):
  HID: roccat: bound device-supplied profile index
  HID: roccat: add KUnit test for kone profile-index bounds

 drivers/hid/Kconfig           |  9 +++++
 drivers/hid/hid-roccat-kone.c | 65 +++++++++++++++++++++++++++++++++--
 2 files changed, 72 insertions(+), 2 deletions(-)

-- 
2.53.0

