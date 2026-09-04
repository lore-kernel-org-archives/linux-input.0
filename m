Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF213E7150
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538468; cv=none; b=H0BuNUPPb6sjIctR4NwaveroN/LWvvKpF8VvKTCXzLRDhJgdHKwKoeZfonvXdE3mKyd/cumt4Ic0cdIhgorrnlxyKfApenPQ7kz7Ox53GoR32FLJ7PDxST8lD2PkxyZqMfCXWJDTunRiwmDAl/7rILlcy1vE2HqhXdX8kAjcz2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538468; c=relaxed/simple;
	bh=XUtnp+JADse6tbTIpqBlX90KrkWPNgb62TRGVh/J61E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FldjJVALgwOCtIT1J+wEzBf9duehNAAskMGj0lPG/rOgutQb0Y3gFDz7l53C+qaAI86QBwOjt8vUnqTBvkz7KY6qzC6WvOXWjHsQuF9vZwFZTdAgpFAozXxIu6JZA2ArZ7dvlYRpqTZXH5AH3qvMFHLsLYlxXXaX/8Hf989ujOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuWNG9j7; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuWNG9j7"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-46b037da544so631213fac.3
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788538466; x=1789143266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XUtnp+JADse6tbTIpqBlX90KrkWPNgb62TRGVh/J61E=;
        b=QuWNG9j7QjnHx1HvdtTlOYWHELh+hsE4IbQH4tXdbF2Xo2LpaKZdNIxZuWiLdW22gW
         AgzlFoDuucH1hE1MCCz85VW2vE1JakdcxIoRBQ04CvVyhHTZdYEsY9coLtHcMP4xVeW/
         X6erGwR0qXZB8ZikX8T2ROEy4sWhSe8ArcCbZSC5q8RI6cWwNd/BWAr6S+bkZOCCBHxe
         9ta70EaCILTEcsb8P+9tLwAvMFgJ2w1whVy1f80gzOiD3AFW8xXzgxeRqmSxnHwbFK4W
         nbhRKmBVmkMAQ+nNvOVBWyNMiwR0ZPbFTjugSjvNT8BlkCIq0enoIIhL5iJN16uDS0I1
         P5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538466; x=1789143266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XUtnp+JADse6tbTIpqBlX90KrkWPNgb62TRGVh/J61E=;
        b=U+MQIEjSFmHLkpfNzv07CCemM/pZ1ARr4PBAE9FmFI0Ce/GuyXPKGQXBgOYzT9JtKy
         1aQMywfFjZ1nxRDhV6z8zFlra+nbK4I4aqspUozaDYgPsyExs3BupohMqG8Tv3HLj0ff
         aqylQXyrvhSfQzll3I9owqRGLdky+XaRJ/mcgs/qJTUHIl5+DKGKYN98+kvx54kzKxxn
         YL1bgdJWGmYFyc6rPkOa8Qv1KdBmn7RF/L8qukOy0CptuLkK4lZ6CkIFf8X06vqkRkWb
         QH5WBBe9WfYSh0jQB8XtE5ysHqV0ORUfJGuc/o7JnMP+lnJ1MsOV1kqUrmrl2f2aozcd
         7LdQ==
X-Gm-Message-State: AFuF++k/sWg4jkFEkrFYsv46RPw8TOQCLT6B6imPp65oo4PylnkLqZa6
	I1WM3syT/RzIy23C2joojAOwOYsKx8lHpv8SYxMiFpjoYkBPG6RwaUO0BV3B7z41rpk=
X-Gm-Gg: AYBFou0yvbAbn0YNPcfpOP2Ambe3ocfXuZPgsdDWg1BcgCRoth87zLJrOeuap0dnbM+
	Nk7B8rUvte52RCvVUb+BUee16haKVXTQnSk27bKmbRs5lLNPGK7FyBSpGQbkfG+j+PSsQAxLL2R
	JVBcQre3uRsVt7UisSDkndPcNoQv+vQ2z1efYthgPGJ85i35AQtmAo47djcbzKysyspmwitXgQ8
	Hek3DQXpR9iKWRCbU4dATjH3I7T0W/oewWzLaIq98don5RGH4U7Ovxkgdj46R0exhviEF05H87y
	cG8DEtfZ81O4Goz3skAwCQqjaKb7OAPYVx5AH2aZU86k52Rn1v/ZZQdoTnKG0PeI6nsCm9KIefl
	/Y4eg8NMFMsUBJ1An1Ruk4VBYwruhe4PzOkVmC1D7rxRzYMfFlRGQyAtzoG9pqf4+nq727uLHa2
	+UK0858E5odYhZVg/byzLFWPUIpGQO3ZH4LbSf+A6/PSUWn09ahiPTS7RFLVoLQ7+l3ydTdagSi
	jvN+ajI3Y/KlvVHRzz1JphJOHFSb0U=
X-Received: by 2002:a05:6820:a281:10b0:6b7:8415:d798 with SMTP id 006d021491bc7-6b78415d8b0mr2054381eaf.67.1788538466305;
        Fri, 04 Sep 2026 09:14:26 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dd07214bsm3597912eaf.10.2026.09.04.09.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:14:25 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Danish Khateeb <danishkhateeb03@gmail.com>
Subject: Re: [PATCH] HID: corsair: cancel worker after unregistering LED, not before
Date: Fri,  4 Sep 2026 11:13:54 -0500
Message-ID: <20260904161354.159922-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904145330.BD9E41F00A3D@smtp.kernel.org>
References: <20260904143610.119808-1-danishkhateeb03@gmail.com> <20260904145330.BD9E41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> - [High] Reordering `led_classdev_unregister()` before
> `cancel_work_sync()` reintroduces a Time-of-Check to Time-of-Use
> (TOCTOU) Use-After-Free race condition on `led->cdev.dev` inside the
> worker threads.

You are right. Please drop v1.

There are two races here and each ordering fixes only one. Cancelling
first leaves led_classdev_unregister() free to re-arm the worker via
led_set_brightness(LED_OFF), so the structure is freed while still
linked into the worklist. Cancelling last leaves a worker that has
already tested led->removed free to dereference led->cdev.dev after
device_unregister() has freed it -- the race eb51c9f8cb4f fixed. v1 was
in effect a revert of it, which I should have caught: that race is
spelled out in the changelog of the commit in my own Fixes: tag.

v2 uses disable_work_sync(), which waits for a running worker and makes
the later schedule_work() fail rather than queue, closing both. It also
converts the fail_sysfs error path, which still had the second race.

My reproducer only covered the re-arm race; the other is a few
instructions wide and I could not trigger it. v2 says so.
