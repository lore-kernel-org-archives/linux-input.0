Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27AD54705E
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791693951; cv=none; b=Nvbysf+z8eAl9l91rZdRtEzoFmaqgIEtcMpBPT7Ae2b2XNuPKGGw02c3FvIj83kut7n8795MFFA1R6kbvQT0MXkuo5n89+lS+cdwzZclxKy7TZpfhWMdtQei534zUK/9kcQDSMBVbVYHJEEIIjdnO1NWE/cPK8FqfGPDZAuWvJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791693951; c=relaxed/simple;
	bh=mjLp7zGDjcj+lWq2bQZ2AdxPlmTKABqImeXoPORHywA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR7lgozcO9TiQLMnWYKJqsUHZPsjJUJv/1qi22D8phJZ4vtAfWiYPLq/EQZS7auDswArhYALKaN+MbFVI9zqEM7mKQ5BQJOsUOw7bNnMU0d1SG/7ZI7GuH6F4dMIl881gUVZYdjS6ZeX/uhO8+bQz8EcVZx36tCg6ZL2ZvStcYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLZimdj4; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLZimdj4"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so1503969eec.0
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 21:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791693950; x=1792298750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UboHhp6ztrYdIlQJYxWz3PqYJoK6i0hu7qVE9ptfsZE=;
        b=ZLZimdj4Xgd70easqAY/MeZ5KEj2OBJDd8ar/eFBPW0b3wdAsWQRizoQlpZYfrkQVq
         M4aCpA2O74HBA9P9Nbu9ikrYhhNKIAhpoB9zCVw87iKzlUOTwpIPHo6sn3Ze1bhSprin
         6QOTNOx1gmVpO7I1zTveIQsLolf6haGWVPbA52VdTtw3aQGUyhTVSt2jebBqKVXmsIWv
         AvhcpqobtCF/ddZTn7mN/urphvd4Jc3rHOxRHGUumc26i431RgVAAOIKxsty2rpzWC9j
         0esB2KZmPJmbelDZEn0/R9uTnMgHPWiiTRVNBPzJPxKkWCICsLcYfA6nF1BRXGpwa1pb
         yNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791693950; x=1792298750;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UboHhp6ztrYdIlQJYxWz3PqYJoK6i0hu7qVE9ptfsZE=;
        b=yBSz8KsxtPoXlHZQBRIrvlPlaqfhFmMAQ1NcceTuYr3NoaDpg/+MWBYVqeg59DqNeW
         Ds8ezZi/0UBrV5F8Qd1FCwbIOf/6CyxJXZpPlZyQiIrzPFGE2FLs7BOy484gCNN10GRN
         q/UUxMxTi7ipPRNyryVwlJiZBnjUgMnJUBTYVv2ZVLEJGdBFdpsrlWvBkl6fq/vtUOb5
         La8u0Ot9L6D+WDGV6GO5hBF9vQfT7uKtRhEm4HrqEkDuu8m84PMEm9rqT7hbR9sVpfxG
         XgKsyxZQ0tTTcUvay9HJH3Y/ud6zrWuF2B60Ad4p3QBILrU/7EHUnTYEr5dKZf7PG5na
         PVow==
X-Gm-Message-State: AFq9FYIcSU9bsN8gfct370tkxtbIweqnEUqS841tT34ZarfeCcpLw+v4
	dlX5Tm0LxLOy9AAvDvXERfZqAFMUSY4MZ4cDTgKHxcchDnRmS5lsMwv8
X-Gm-Gg: AYBFou0Gm4LV2i/OVeLdV5wr7kZ6bc6BOpwQDFKfwRiFe7VLskp/xYtPfqR3u568+bt
	oxSPZTuI2DofPJf/eQr47Rca0SE0EtGqzecAE8hUS1LRXbH4mmES7qHgilvjqyrl02jF1Oad4tV
	VtpXMlPINZ93ia/cQqS+uSYBcmBtoVaKpF2Miqh/tV8f5GBYbUQWAtxQT/RXSyXXoD2KpXNB5pU
	TrlMSZbn+u4et67LxXVZNPkGRQ2LBWxkCLRAdpypVf1dkfJtSx4Uj49MPN9bAsKGMFPnY9q/XwU
	Jd3ta0dtkXjGPdkT1DulvlNIdJQuxR7kschB7u1EKPgTihPxQBr/I27Bx05zXIQHOiFKYyRFJz9
	hZYSjxzO4bNE8E7TjYYSO6bTrEdih3glmDaEnDfqWxmoiTwx0ZU+kY9CFAYWeyXX8x6hUGDKWhY
	DzoUn9lyFXHkzyurs6AJMoyciAH3kBNzu+Boc7nDhoTKE+gfT2bazcH3drvqn7Ey6yWm04ZcWxc
	RR78U3iPNZhqC5YXFIaCPiINQ7hT5gCImtFQdwa
X-Received: by 2002:a05:7300:f582:b0:34d:755b:d60b with SMTP id 5a478bee46e88-3537e048b67mr8414896eec.34.1791693949428;
        Sat, 10 Oct 2026 21:45:49 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:99d7:6eb1:9874:c6be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm21542311eec.10.2026.10.10.21.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 21:45:48 -0700 (PDT)
Date: Sat, 10 Oct 2026 21:45:45 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Karlos Abel <kabel@voidship.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: discard pre-registration events and test
 state seeding
Message-ID: <assT056aFmzMHmON@google.com>
References: <20261010180031.7-1-kabel@voidship.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010180031.7-1-kabel@voidship.net>

Hi Karlos,

On Sat, Oct 10, 2026 at 02:00:29PM -0400, Karlos Abel wrote:
> This series prevents input handlers from receiving buffered initialization
> events after device registration. On a ThinkPad T14 Gen 6, a later LED
> update flushed a stale SW_RFKILL_ALL event seeded by thinkpad_acpi.
> The fix drops the pending events and their timestamp before handlers
> attach, while retaining the seeded switch and absolute-axis state.

Could you explain why these seeded events give you trouble? Is it
because thinkpad_acpi() forgets to send input_sync() and so the
timestamp is stale/wrong?

Thanks.

-- 
Dmitry
