Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325543382DE
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780371897; cv=none; b=Ylz2bvTmSrj9RKmvamvhlpUcxFXDi4bhy6V2fP+Kqzj0+U0MYJ6yQYu5aKioD5dHHoG+5i/+ZAqcmRfn8WsRX7biewHMQ9GdAwqpEBT5xFQHXbyzM1aikR7kSQnONyB4CYFJc8yDimKU+5I7iZb9eretI3vKOsFb0My9RAnwqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780371897; c=relaxed/simple;
	bh=mRYJ7PxOrFtv65CLLZ54456b0DWYC5nxECBKHwzvqXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uK5WG5RR8kLNc35wK/d6E61e0R6s2sVAfYun7XZys6cZVHM5U/9+b+Pwjs8FPIRvEzFFf+u7l9pOmdQLYGxaLOiy80wZIJEW5m7MVNgJrFXzt7CokNi3mTV3of8bR+GkuH0CEbv7b7kxRiJwAxUOaUXJy8HgV+5SfW/B66442bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j56VatWv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j56VatWv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b2903757so411505e9.1
        for <linux-input@vger.kernel.org>; Mon, 01 Jun 2026 20:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780371893; x=1780976693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRYJ7PxOrFtv65CLLZ54456b0DWYC5nxECBKHwzvqXA=;
        b=j56VatWvGaz3veX5e2UPEkNGoQMxNYEVcdmYM/PmAY2eOZNnC1fBrD+uccJOEpZbNO
         68yi8IttcWmqpvX8mHUuJs5Noahm7w3/z9zLSuYXpihOGXvfUM5K4tklFixKjCD1+ju/
         daYVRKvofGTfk06qaqxXSGbJJH4R+8hn5BizMs57o/AKgQTuRBeKiwCv9PX2ZEFfKSzf
         WwM4XR7eRV9XkraEgzOkucn9wygcxaAYaAoeREHTgo0hDo+/TW/r4kg1bsTa124ijoXR
         U9OK0fwjHuprh4wwsCuA3vysM6s3j2wgmB5LwE3P+22b5F1js/dgIOP51SWVAdKu8qau
         NC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780371893; x=1780976693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mRYJ7PxOrFtv65CLLZ54456b0DWYC5nxECBKHwzvqXA=;
        b=dQ7kDhQcdndGleoq6zAvZUi+kLr+wk5xTISLEgXLS6NDZUDlSJUnmVT4RPE/SL64Sr
         2Sh2ia5FA7tOI5/mX0RWknGhXk0ZnzVQ8oDuciFfVhDZXzeP50yLBzS1xEuhcu+f8ELl
         UJQCwz/dKAfDA/WNl3nakQxDlxHq2LK0Kipt+HImAqwsWyd6dEnypzYaKxcEKrEzqscH
         djkMIWuE8EMn5TQ9Ax/Fwf1THG+nhyjTQ6Cil0by97uVquz2I9YQryY9clP3j6xQUAwh
         OQj7fN3vPGgB7ppFiUd66RMpKZKNvdKJQur/0XybzAVbfMJgYcy0xDZ9b2apllPk9yp4
         D0IQ==
X-Gm-Message-State: AOJu0YzYs+bMrWmXSoBv1cDdSJJz0n4puUti2yNcd/wvQAUHLUViLnmw
	OLWK5pqXOqHwhr783pcM5nghTuC+CU3FSgVPs9bGtl8dwzivWqJJDTs=
X-Gm-Gg: Acq92OF64Hkbnoc7WNQL7hX6NBPtTnw0n9OLU6jWTcbrTpHe/YRri5T1PW1WsttTPUA
	aSgxe/5cK00wjdVOV73DbJCgt/AiKa21bIYi8t7l8LNpzGQg3SnfN4HU75H1NhLX2BzLtzj5DIP
	AxlMRRIjPlIhBD/4Mwa/quPKLFgme0vUrAKJ4GSopeHB3heC/V/1wrKysqHYi8HLz3weh36UHiN
	+rePd33s/xiKItl2kkjJTrQl1kILKXuZIaU5/PNBuGHetkEDsz5BjoPrA/GmK1+xr40YI8qddy5
	JpmB6YH6Ka77GDwQv/621n73BvdAWlcEB9TrNABJgeu2arwrJFfg7XgPpkALdsNi2tpgGfMHFdT
	cbL7NYZi3UC5yPsMdr1LbMamvHM9hGDxmenU0N5A6lYGrLO74wd5SGrlPelgyhYWIqxHPZiy/xB
	NXe0CjPZ7TBF2KwcW1a6Uk2PYCnz0usl93v1YiNR4dmPtFYxYB2/thVZHmVY6YZqbOodhSqNM5m
	5OOwOmFNrANWF8DOuziiSkPevaOV70xoniPd0FydgpfS0yoIL9vnVePO5YsZradw3lj5VEJMZN9
	x5BeEKtLgmjOKHSjBbqk16qtcQK+8sD9u1woKLhhKqQ/OGzpwqMuTg==
X-Received: by 2002:a05:600d:6405:10b0:48f:e230:29f4 with SMTP id 5b1f17b1804b1-490b0ea300dmr21500185e9.15.1780371893353;
        Mon, 01 Jun 2026 20:44:53 -0700 (PDT)
Received: from dev-debian.lzampier.com (brnt-07-b2-v4wan-169550-cust456.vm7.cable.virginm.net. [82.14.129.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0daefbbsm59794995e9.0.2026.06.01.20.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:44:52 -0700 (PDT)
From: Lucas Zampieri <lcasmz54@gmail.com>
To: Rafael Passos <rafael@rcpassos.me>
Cc: linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	kernel@lists.ime.usp.br
Subject: Re: [PATCH v2] HID: Input: Add battery list cleanup with devm action
Date: Tue,  2 Jun 2026 00:44:51 -0300
Message-ID: <20260602034451.398835-1-lcasmz54@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260602030519.3097058-1-rafael@rcpassos.me>
References: <20260602030519.3097058-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rafael,

Thanks for catching this and the quick fix. Turns out this is the
hidinput_cleanup_battery() hunk we dropped in the devm conversion
(patch 1/3), figuring devm would handle the cleanup. It frees the
hid_battery structs fine, but never unlinks them from hdev->batteries,
which outlives the devm scope, so the list dangles into freed memory on
the next probe. My bad.

Acked-by: Lucas Zampieri <lcasmz54@gmail.com>
