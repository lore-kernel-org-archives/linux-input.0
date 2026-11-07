Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794024190;
	b=YI5WKiUyXL4ZkEr23ofhm1NPjIRFSF8OCvCeBCTtGcxNjWn+raJQRJgTRhg6ciWgMnIE
	 vpRoyvaRgF567tsKbl3LeUdC2VK2HZWNiv0MTnwkoJ92tDa6p4WpF3D9qeOSuXtvCcpj+
	 qET1cv2sAgdCmKoRLFzY/9Hv/zQXc8Mr6aSFG94zo2cFdESlDU+xioj2RKUx3x6GNfA9u
	 vNdmUHLUKvczdRIZtSwoD3kLAztjVYpKaepfrukijGAtPHYHJAsmrz04ipqXxkXqXkFsN
	 psx9HF843Zvx0B6+nwqFgbtft32FWA8T8LMrcogBz0OQ+GgTKMj7ac2o+iI8NZEOfqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794024190;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/pjtlCWW9ZzEOknfZ5Aq+rj/fQ7vV73C4LGJl4BAYzc=;
	b=zc9sVETxKh52dg1MWrbue4jQTPfRHkSDD4JWIeGIj8vk5L93qgR+e/jGGHjG1wdk3hh+
	 qSEBAIAx8R38sNw+1U8sObx29VjyXs7bhZEKPg1akBEJq2VcnQIDUeVUI0Nui8YT+1g2G
	 ZtlgXkJtsAgMlTQPNKM+h8YlVH++czTo1+EfmecXP+TRosf1yt3Z7AAMX7aVy/6j9ZiiA
	 urDTB0YM5jDu2W6oAXY3JqMzCOIbLqCIe5sPYYu2IiK6R12S6bPQbrzDLg5o/uOTlL9w5
	 +QbAaNu0TvmWLaHYVZEEXSYgvMYoiMENLPKm2otPQgB0HmCBN61i/YYjlvN0CgBc85Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGcVeB02;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88021606A326;
	Sat,  7 Nov 2026 04:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGcVeB02
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6691F0089F;
	Sat,  7 Nov 2026 04:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794024190;
	bh=/pjtlCWW9ZzEOknfZ5Aq+rj/fQ7vV73C4LGJl4BAYzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HGcVeB02p1jiLo70HBaZ8aMTwv3jXc6ZyOcatCCuHcd9xz7XyGjPxH8oQRz4GKv65
	 fFHX97sY8muO/RRl4YDaVJBme/FrwO3Y2Np8JytlvkGfjVIqkt3AQC3OVD9U9mXqS+
	 voZK87Pml5CwrqshzWG6tibGJVQa8djedFCnph5itaNS70TYe9BUSLxXxnq0a0Stg0
	 kNxMdc+uisHjWyaL6Z8vI+t8BF0/8Q8sEQeecmypfc7clq6SkRHc2jcq/fM2ja1cbg
	 La3tynj6piQa4lUm/0tHfllgaILP5xhki4JQGfioJ9LwOckAAVVMnPlKg5xPaIQgzW
	 8J1R614lFoxJw==
Date: Sat, 7 Nov 2026 04:03:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] HID: iio: Unify probe-path logging
Message-ID: <20261107040303.33e638e4@jic23-hlaptop>
In-Reply-To: <20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com>
References: <20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Nov 2026 18:11:42 +0530
Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:

> This series provides consistent support for logs in probe() path for
> HID IIO drivers with suggestion and input from Jonathan.
> 
> This is followup series on top of multiple sub-series submitted for HID
> IIO device drivers which included fixes, devm support, cleanup and using
> preferred kernel coding style. This series adopts a common logging
> approach throughout the HID IIO device drivers in probe path.
> 
Looks good to me other than that cleanup Joshua suggested incorporating.
Given that's in the code touched in that patch, make sense to do
it then rather than have additional churn. So I'll wait for v2
with that in (or more discussion of course!)

Jonathan
