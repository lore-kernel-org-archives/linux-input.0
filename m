Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250E73BB13F;
	Sun, 26 Jul 2026 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785075087; cv=none; b=eWeYvJYmzp5CSJklOU2uu3twKSdEPBgR+Ph3iyHNymzsD/02q099TAMpXGDsqPuZ4INdvryUlRR41/zk2Opo7YF1I/AES5R4SZIok2I1+cjbCvtIwwa0Sw1KIV8cYUFSB5aUQeu6m4DpZFCKxqyrutSJNB/hqWEhTvju3LAcbBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785075087; c=relaxed/simple;
	bh=RsM7wLQ/jOnJ2CAOeD6Me72MGP1YsDb+SowXpnXJzvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCPKoBpZGA55XoQfHNGiOVkxD4jbgfnfLUgcqRKTFS9HgLFfYIc+uwTbkRzJFiqM41u0UGkvdiYo8eplTOT9l/NSLct5Um4LQDBGFu+1N+ghsZ1YbICk/ohxcB6moftdFS5vUB1d+TGrmaGeCCaGL0LU5oAZsbMGEVZg63pCzew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PicAm15s; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PicAm15s"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 31E5540E00C3;
	Sun, 26 Jul 2026 14:11:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0d6Ot8_kfMTT; Sun, 26 Jul 2026 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785075070; bh=r8doXaDn6ecHI39IRrqLZtoTpcRGraO81Kh8LY5Konc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PicAm15s5uT96SZg3N5NWfi+nCimx4ItIGt7nRIwH+6Du9jqDhyW5STVkhbifcuL7
	 4JQCnJ1b/WdEduujnyrWslHwKUejWKGmu000WgsSEZvlvQ4e1jkD+pdkSfPcT7zSnU
	 JVf7fIuElseMtHnwIJWZDL4jY7lLeDMejnaxUN2Wi528uwBP6KtsTMBflle1/sGmQ9
	 PCNvUcQm3J3MBK+ENZfF5fsFGDBCZkQczEgrhGS+6B2kDbF33DP/pUaXp3Rdfzgp3h
	 Mg28cYxc6+z0Rb12nvJZD5mkxDm/+28zUex+Imiqr738I6QMicj42IgC6CFQDcQuhI
	 v1aLwwFEV+Hs3EUnzQ28+R44SQ9JXFzMX5dKxNWYAkgXcMfPVUs87XC1CQ9pI9iOhu
	 4x/0EodwXBAnF0AC1LlybjC/K8ADD3ZCnioQKWcMPAAJMkzkn6Ed/b7vnCN2ZZfnns
	 g19aV1R8B+hLk/nH1JImgWOuHvKNirKsaAbIrfXT1fN2dm3BBliOY8hfUjvYrUOzQ4
	 hg3tPClCDuJe45kY0Q5GsWBm34c1B4fGcT4Pa+uzeRc2g+IyOXM5r19vpb+uHuG8PV
	 hsYj5GRZ/SloQZMSg57Q23s74VhXbOhcyHP1pasyHkKda5DqY3UsW9ZFhXbmFVUdo0
	 tvhT5aBPUeYNBwHuOCbWzvEA=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE79640E00B8;
	Sun, 26 Jul 2026 14:10:32 +0000 (UTC)
Date: Sun, 26 Jul 2026 07:10:29 -0700
From: Borislav Petkov <bp@alien8.de>
To: Eliav Farber <farbere@amazon.com>
Cc: rafael@kernel.org, tony.luck@intel.com, guohanjun@huawei.com,
	mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org,
	laurent.pinchart@ideasonboard.com, linusw@kernel.org,
	brgl@kernel.org, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
	zhang.lyra@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, dmitry.torokhov@gmail.com,
	hansg@kernel.org, ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de,
	ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com,
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org,
	pedro.pbg@usp.br, paulmck@kernel.org, frederic@kernel.org,
	kees@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 00/13] notifier: add device-managed registration APIs
 and convert drivers
Message-ID: <20260726141029.GAamYVVeVnJfH5ebH5@fat_crate.local>
References: <20260726101739.33170-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260726101739.33170-1-farbere@amazon.com>

On Sun, Jul 26, 2026 at 10:17:26AM +0000, Eliav Farber wrote:
> Many drivers repeat the same boilerplate when registering notifiers with
> device lifetime:

From: Documentation/process/submitting-patches.rst

Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a week or so; if that does not happen, make sure
that you have sent your patches to the right place.  Wait for a minimum of
						     ^^^^^^^^^^^^^^^^^^^^^
one week before resubmitting or pinging reviewers - possibly longer during
^^^^^^^^^^^^^^^^^^^^^^^^^^^
busy times like merge windows.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
