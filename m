Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F96648381E
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854525; cv=none; b=V9j/PhXK+1/T+OcBkDuZXvOsjwoR887EwMTTrsY+xPWDY+8yOKOrnmxbbZNzchMOoGn7e2iyquzKOXjs6uIe+8G33Y2VdZaN7W89Zmz7GVJJ7G2PWyrLdABU9+IVOgPRIxHZ3o7HPrGr1eOKNgJ4Sp1u2kHOkxcV2xTFZfquF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854525; c=relaxed/simple;
	bh=RBsNvOQrVxRHUyjRqfTfJUZhqdTeMeE1bFwzjn1jGV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0eAwles8t8dS3uNbWDeh0JDBbgmzyp7YHWGLH737PmIgxqZwz6w+YlmttmIFkI2MW2KaUtoqfLOydWI6Hx2eFqhP+SdK+H5edkGJsrd9XVWHQacEmKOl8Mvfgq+er9tQJB2thLd5kFQW59k5A8c/iizmSmuzuY3o9DKmhsahZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+k4ivX2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+k4ivX2"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so8170805e9.1
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 11:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787854522; x=1788459322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RBsNvOQrVxRHUyjRqfTfJUZhqdTeMeE1bFwzjn1jGV8=;
        b=N+k4ivX2dm2WVdNFpOg5OzOjPPK0oj5zSRthgrFbCc3FK7Q4UcvEHQNlOHKLmHA5Eb
         xZ+otv25WsMDEB95eynSKvQP2xSTDjbUJPCoB5VK6BZmiQY1L6c20jsaBuu7xtH/tQAU
         o0YAO+i4f6hFEPFYxW0QMv56Ketd++plxB/gta8BBoRElJzhZfIalcnfRMc2pchoXX0z
         DIC9OeMUS9DFS/e++Bj2e+Ly95jfWnySomwRjcmWhwWfzWoKzHL+n7TQS+PIYlWLxRaP
         ER4dmh9kZBjHY++yVpZKjlR/myM20aX0feaAUa0ALWIjYqWPGvv09Q1VovUQ5FZ0k/43
         Cxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787854522; x=1788459322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RBsNvOQrVxRHUyjRqfTfJUZhqdTeMeE1bFwzjn1jGV8=;
        b=jRb/aW6/So5O9EmU2wb8yS//EnDTS6tFjXWFpC2jxIN+ZY5m9Cemh+4sAyPmT3Eu5y
         tk9Ag3HUeGeQ6bBV1mbbWHSCaPEFK3PxN+5sL+nJPSLu5gnOCUoQHnM9zKssXtoMwuuc
         trzLDD0fvm9mJpaHoN5VyXLrXRf+WSWOC4Xu78EOIJDv3MwYFW7ltBi0h08hH3nDSgC8
         mpiemHmo9fmuMhUwdL9Rb3+kDOGzZb/p6k+UCyjhsRITUt3EKUXPidMqlUI+vG/kLj0i
         n/ejWP+De44HyABPg7RNl8z17DMMXInU9gQIWvlNyHY+7kOT8yHV66Z0jhNCIUFwEwN4
         Lb0w==
X-Gm-Message-State: AFuF++mQSvfz8lBEAcY3Cafg5WBf+dgf8u/b1tyTM+pi/OVQxI60z9oe
	aZesG3frSt3dwO0xCGdJkFdI8H4KCCvlQrUQJOz/Z9mpWtssvvtZymwK
X-Gm-Gg: AR+sD115rSdTlLVIMeHRgnOaYNPrra4Bzu2nvaGCbeZlEYPEvamKoFQlCS345uR79+x
	M1Xp1L48gZmwRhMpljNDrk9VgZOQXNkc81mvSkWMS1TzmIFbEspJOyLILFsJ/UJh65ALaZyYSmS
	PipM70UV+boweKVFYWrQ0yWtz44vyM0JHGeAyyM4pC1ilxzDKko2B5aeNY2SBJUtaeW/tiKlUdE
	syLAn7Uo6xGfRqEMRBIFqs1idZQLNCWVd9i5gLq/YQDhl8+IwCb2mh+I8frXUCl2V4ALdp+0+eE
	fuCqKXTD/zZNSN2QxcPbVwde4skxGp3scq788++ZPLLCaar8Tj7UUwF5oHqWGFHVlTDN8Ay2lUI
	c6FI7wRJvMxDRqGOgqiUulmnlO1dXvg7cDqtP9OKVUhGcLbGjMbZYevLFLANunnMpjzTuQH4UKp
	WdDqpduq0fugeLUsWusrK4lUSP44OP8rt0LY2luryJRfmVEOnfR2vphNsbZnO/sdfJyw8WLuN4P
	Y0nNLqRzaMbxvdHOb7eB6mek1263HRm8KGo9+hHYZ/7
X-Received: by 2002:a05:600c:3b25:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49b91a67d36mr12068965e9.6.1787854522377;
        Thu, 27 Aug 2026 11:15:22 -0700 (PDT)
Received: from 1Z10 ([78.213.170.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c5790csm5825985e9.0.2026.08.27.11.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:15:21 -0700 (PDT)
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Heidelberg <david@ixit.cz>,
	linux-kernel@vger.kernel.org,
	Maurizio Casciano <mauriziocasciano7@gmail.com>
Subject: Re: [PATCH 2/2] Input: drv260x: Map ACPI enable GPIO
Date: Thu, 27 Aug 2026 20:15:19 +0200
Message-ID: <20260827181519.2426159-1-mauriziocasciano7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <apAXfjxVv8e-yxJ7@google.com>
References: <apAXfjxVv8e-yxJ7@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Agreed, thank you. I am withdrawing this generic-driver patch.

The enable-GPIO mappings are now supplied by Yoga Book board software nodes
in the platform/x86 v2 series. That series also carries the supporting fix
which attaches GPIO-provider secondary software nodes to the matching
gpio_device.

Maurizio
