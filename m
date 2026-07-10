Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCBD42E00B
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697731; cv=none; b=stc+RR6jiPhO3L899BXsNNUrwbOtJaDM/okINYrDnGgPy9JUgwMWqzJ6jkMbqPYUTOAMW8wuv8krd9I1UOXmNj/oihInnYRAYRRYA1lABVzws62lT/Nuga6hotloC/OX5i/rz6YR3PVVCjLvWqo+77QN92639arFJ8TSVkaJoN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697731; c=relaxed/simple;
	bh=BQMmmlth5x7XSnvCORK5SgU4QK/hUZESKpalnO+zLcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EgR8LqNlVBs2QSwR+0DVCOz+5RO+/YnST9KOa9dHGsTNPMqwaamXSNmQqPG6iazCJmzUc5UjA1aC3C5KwTD55a26i5vy6upuQs34nelFUK2IZti8C6mvEGSBB1mKhE4y0DoYl+vTT1e3PgGNQBxtHxynjjoN/tvuhnM7OFcfE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=af9Jf61r; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=RG22tN/E; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="af9Jf61r";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="RG22tN/E"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=af9Jf61r6XbLH6G5Hn2vkOx81U74BKLeYj9HhAfK7v0WG95or7hq1RmburfSWg0LKR1+6br64SWmq8GDXyg0HenmJoo7UVKNqvk01LXZOo67Ali7AaJUkG4Ifl8nXxnHNcCHgZhQopI1Xg0cl/+XusRl7NJJheWhmGmuhU57Vl2wSvQ4PCjGcGwDHx1XGDw07EyZInUdVonkVLAxS4ZtUJ6XjYSih/8yuW2SvbHud3Q8UPYwV4fSHBZY4b6+wbfmGI8fkkoan/LmjXWO1kDe0dzKhNshgaicYeyMo+86E1gjPbHsvwPRkQPLADfW5nJ7LOdo99vPqC8bgOI283GGpw==; s=purelymail1; d=rcpassos.me; v=1; bh=BQMmmlth5x7XSnvCORK5SgU4QK/hUZESKpalnO+zLcI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=RG22tN/EsctoltfBDL6+sNHeUFONQb3OZ+gF6fn6/6gDbrDFqbO8FgqUUB95Uu1Wp2jpYZbGxuNVBNFJjr1aQ+L+yutetUNqnugEc/RcgFaDFsMs4g/xby615H0OVSsJ5US8Yb5qI9n9EMfNGOeYImeLVq2ZYP8gK7FwNd+FrZLoN3b5DApTkjO3K3KklQgcWI353/YsRolvuQAs6wXwjJQqoxMY0LzURCZdBH23723P62CeD5oFv4h4McAcZ4nPuCJP6yjxt2eKC1njnKuZ63D2+qD9ddHHvi2hiaPRUqUmg9FqwmlHI0qAHkc7zgamQ4HSolkl4UJaxwhGuHCl1A==; s=purelymail1; d=purelymail.com; v=1; bh=BQMmmlth5x7XSnvCORK5SgU4QK/hUZESKpalnO+zLcI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 445827024;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 10 Jul 2026 15:35:16 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: bentiss@kernel.org,
	david@readahead.eu,
	jikos@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH 0/3] HID: wiimote: new LED behavior on connect, and scoped guards
Date: Fri, 10 Jul 2026 12:32:08 -0300
Message-ID: <20260710153456.2093889-1-rafael@rcpassos.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Hi,
This patchset contains one feature change, and two cleanup patches.

The feature is turning different LEDs for each of the first 4 wiimotes conn=
ected.
From id 5 forward, the LED will cycle back to 1, and so on.
This uses the ida struct, so its quite simple and lightweight.
The hid_info log message prints out the controller id.
I was considering adding this number to the controller name too,
but was unsure if this could impact applications using it.

While implementing this feature, I decided to cleanup the code using
scoped_guard for the many spinlocks in the driver. There are two places
where the original lock/unlock version fits best, and I left them
untouched.
Lastly, I used the __free scope cleanup in the LED probe function.
The wiimote_hid_probe call can also be changed in this way, but I
left it because it uses the wiimote_destroy in one of the err cases (w/ kfr=
ee inside).
But I can apply the change there too, to make this more complete.

It was really fun working with this driver.
I tested it with 4 Wii Motion Plus remotes (gen2).
Video recording of my tests (48s video).
https://rcpassos.me/video/wiimote-led-linux-driver

Thanks,
Rafael Passos

Rafael Passos (3):
  HID: wiimote: turn on the LEDs indicating the controller id
  HID: wiimote: replace spinlock pairs with scoped_guard
  HID: wiimote: use scoped cleanup in led creation

 drivers/hid/hid-wiimote-core.c    | 252 ++++++++++++++++--------------
 drivers/hid/hid-wiimote-debug.c   |  41 ++---
 drivers/hid/hid-wiimote-modules.c |  22 ++-
 drivers/hid/hid-wiimote.h         |   8 +
 4 files changed, 165 insertions(+), 158 deletions(-)

--=20
2.53.0

