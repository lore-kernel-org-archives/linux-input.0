Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A53B36826F;
	Mon,  2 Feb 2026 13:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039500; cv=none; b=KLL0JsuzIq5FIjn2ZgVv5r7y8/hlAsvTect/ly8/7JpG1V1IUV1Uxn/FHrJTcA3PrNqIB+SWeprNabcU3c4i0mLkIUeDJgfRLHfd127j7lGkwxvrKEgBG5eeYDI9QgQzFahoNd9BnjHrwlluVKBG8XFuLjSexICnX4Wma8pWSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039500; c=relaxed/simple;
	bh=JC/prxUuTnxBvG1opY62WX8fTjvrGZ3Q4ENZl4Ng6Gw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sChgo8BYp4S3XjXNBQ5fdwIO8OCap86eyNdzYYb3oI2HynP9+tEVpSo8no9BVUIqNOj7y7WfJ6ilVOjhXNqXCF70lvCzFC7vAXIQ0G6Cc8fSUFl6HVkFCekPYNnpo5Mhz6weQ7uyN7du0nbm9mW5H+R5335lwAVDJgyYcS4tx+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5DvUZug; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5DvUZug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D17C116C6;
	Mon,  2 Feb 2026 13:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770039500;
	bh=JC/prxUuTnxBvG1opY62WX8fTjvrGZ3Q4ENZl4Ng6Gw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=N5DvUZugvGg7YzCdhFbiBMlpLgyjW/f9vY297qImtQFe+l2On8AMn9JCf5N24g9eb
	 AdFtjgBdwslns433qyCHjwV6vD8cY4wtSc33GFVFcGhlRPx16eyWBCo7Tdf8Z0ifbh
	 byaLTVD1JVqLYWzmCwr9/ukFZxiEw4gWlHEN9vd/Py7Tbe4cOyN0CehHvjYQZiA9Ec
	 9I/T8vHiQ5tX30rkkc+3iynfnA+6NV1hlUHjlTUfWEukepRabXmffNmRKZpmBFVJYq
	 Rv4eoSViFtI4S1e3pmZ3a2I11cKEf853KCbmuzz+j9hGSI3uMrhqnb4YOo0Fh+SUoL
	 U/l9aqwjOswwQ==
Date: Mon, 2 Feb 2026 14:38:17 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: "Lin, Ryan" <ryan.lin@intel.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
    "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, 
    "Zhang, Lixu" <lixu.zhang@intel.com>, 
    "bentiss@kernel.org" <bentiss@kernel.org>
Subject: RE: [PATCH v2] HID: intel-ish-hid: fix NULL-ptr-deref in
 ishtp_bus_remove_all_clients
In-Reply-To: <PH0PR11MB749313441EEE2608C86E43818E9CA@PH0PR11MB7493.namprd11.prod.outlook.com>
Message-ID: <92705p12-rnp1-977q-7n53-531o753no26n@xreary.bet>
References: <20260130053456.4971-1-ryan.lin@intel.com> <PH0PR11MB749313441EEE2608C86E43818E9CA@PH0PR11MB7493.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 31 Jan 2026, Lin, Ryan wrote:

> Hi Jiri and Benjamin,
> 
> Looping you in for this v2. Apologies for the oversight in the To list.

Thanks for fixing that up. I've now queued the patch.

-- 
Jiri Kosina
SUSE Labs

