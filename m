Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBF63B2FF6
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998050; cv=none; b=WOn3hbbG9EiRH62sZ2/GXftH5Kaimwfs/iEPJEG2nWfYNnLsAAxvWisxHZBAnLZfrY0vVyZMsYJ3lwPzuQ58qP7bfyhTRmvEjNR5UaoOoOcnTxR/JiUIVC0LmsqW5ZN2YyAJBDp0RBeqdkxTYOdsWJhwl9VNi6xUbVTkALgkqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998050; c=relaxed/simple;
	bh=HhIkxRdLFN+6KuFHzBG+wbhz26B+UvNBUwa34XSUbH4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=YA3TXuQYoWYundgAKwEHs3iwrwnpVG/jaXaXI8qFJuSrto4nOgBXGCKfyQ93zA6HLvSpoBzoY716nqub3WWU6aS7INlNJQFsw665XpAV01sAcm8jEHg2TYqAci94wD7t1Gch8SQyt0bcnoMo8hji7qYqcCUlIJb9z7ft0wz4Xqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=OZBS+T67; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=YKj0rnM+; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="OZBS+T67";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="YKj0rnM+"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=OZBS+T67TVsNKwuQ/vgWEpUJZbpiGYWJZ/emoNe6/XkIwHMvwGYnGBrcM8fdpur68GjEKfY7n639g5N8thc0tDrSUV6U/4iG9qVI121G5ZY4BJmRciAYDU20Qzwi+cc+FTveD2xF2q7eetOWODIuZA1usGMz8wwI3ylmoISfI0Tv9+UzXhcYP9u2pFqEQqEyow3jj6f5aQBCbrQ1K8sYWTUeMFrSKK5avJ0kwJmUouZl8R3bzd0uTNO6GIZAaa6peNr86RnOYzwSh2MVrZdoYHiX8fcqZO2z59T0CfDgIWSvBOUPHPm/XP0BQXIgpZ5gNXBBZLVx9jAp2B74QKGkww==; s=purelymail3; d=rcpassos.me; v=1; bh=HhIkxRdLFN+6KuFHzBG+wbhz26B+UvNBUwa34XSUbH4=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=YKj0rnM+dIpg9fcjyWVPchTqHsYTO0/K6wNAeqrZNU0Qm9ea7q57PzphK8droIK2k7C5NvVVxCLAxqHwEm6VK74E/NxHr7FnkAurUFveNiCWLPGGbr04YbWlTPXV7SJT9G7q2fpwNfXcZpgVoCBXV9+HhrUulP7FlqpbNIU7yrw0XK1XU6ApGBwR88tXndxmTEdJXM6MNpspET7queONGnoQDgv1Ii2aDPSV6AkYDcQ9bHMhZ4cUU7SzkR23UcCtj9JiDe9/0m5FPK+pCK2lj1yfyE/4USYxLi7t/8bOlV+iEjb3X5PmHPK9ITNW4jvrLy/vUX74wbcjcC6FToxB+w==; s=purelymail3; d=purelymail.com; v=1; bh=HhIkxRdLFN+6KuFHzBG+wbhz26B+UvNBUwa34XSUbH4=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1623918569;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 17 Aug 2026 20:20:38 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 17:20:46 -0300
Message-Id: <DKRHXTB2RNVE.2M2EWJDQ4AQFV@rcpassos.me>
Subject: Re: [PATCH v3 4/4] HID: wiimote: fix uaf when hid events are
 handled during destroy
Cc: "Shuah Khan" <skhan@linuxfoundation.org>, "Brigham Campbell"
 <me@brighamcampbell.com>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 <linux-input@vger.kernel.org>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "David Rheinsberg" <david@readahead.eu>, "Rafael Passos"
 <rafael@rcpassos.me>, "Jiri Kosina" <jikos@kernel.org>, "Benjamin
 Tissoires" <bentiss@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260729164928.1138468-1-rafael@rcpassos.me>
 <20260729164928.1138468-5-rafael@rcpassos.me>
 <f1accf74-c527-4c53-9321-84dbcd8fd729@app.fastmail.com>
In-Reply-To: <f1accf74-c527-4c53-9321-84dbcd8fd729@app.fastmail.com>

Hi David,

It took me a while to get back to this one, because there was a bunch I
had to dig, and I had little time available these weeks.

On Fri Jul 31, 2026 at 8:17 AM -03, David Rheinsberg wrote:
> `hdev->driver_input_lock` serializes all probe/remove/event callbacks. Ca=
n you elaborate how this is triggered?
>
> I can see that external APIs like debugfs and other sysfs registrations c=
an trigger this, but they are deinitialized before cancelling the work, are=
n't they?

Yes, you are right. This is a false alarm by sashiko.
wiidebug_deinit and device_remove_file are called before
cancel_work_sync(->queue.worker).
This is even more clear after my refactor of the wiimote_destroy
function (that I will send in the v4).

Before arriving at this conclusion, I tried adding delays to help
trigger the uaf with xwiimote, and failed :)

Thanks, I will drop this patch from the series.
Rafael Passos
