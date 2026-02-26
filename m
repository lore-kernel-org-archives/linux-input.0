Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2483396B6A;
	Thu, 26 Feb 2026 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772145495; cv=none; b=WL3nR0f0UvOywBV2YsRDVlrwFsEVIGudbGdeR2k0DXoLpD4gTt8mjIZsn6uODuPGi6yGGCTGbpV+XmrWRtmyKldu14VZXfFk1WYAMtMktKsdceODZJJFMcrgWlsxdvbMTvlMNWG+vrCPzXO00DpygNhsIuWkJ/EydylhkMdRNLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772145495; c=relaxed/simple;
	bh=wE/EkdqepmjjJPvdfz9cW0vSfmLcUOCbDNQAeSvrYfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjEIfDzYj082QPCUhGiWX19qGj/Q5qVH6sDznfImtJKwT7zVB7n7b6hKmx/9biila1qY3Wd/9b/nF4HTdT1CnElYpmAmzs2hLDgX1cF5ATqiKnOhUUSMRHehN8SguU4i9EjTO6OUo1Kg287xrP7Ejwzky4fXt7hIWpNu2XOsJw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qNGoOj6e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qNGoOj6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A589BC116C6;
	Thu, 26 Feb 2026 22:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772145494;
	bh=wE/EkdqepmjjJPvdfz9cW0vSfmLcUOCbDNQAeSvrYfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNGoOj6eQG3Npt9kzNjgBJw2oW3RxRRh8pZbHlfQnsQ+AL8TyGRuzG+5fGIbRth0w
	 maSuMOnDNMW6cT5LTnE3LDg6OyeeIWD3YoE9yUhwVmaMJwdCm1OkUHA9jXeeWwf2Mb
	 FVO9VyPRKwv4DiBOrnqTSqoJgC61HmyqqmMwTuVc=
Date: Thu, 26 Feb 2026 14:38:06 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Richard Hughes <hughsient@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 01/16] include: device.h: Add named device attributes
Message-ID: <2026022631-breeches-quaking-e5fb@gregkh>
References: <20260224013217.1363996-1-derekjohn.clark@gmail.com>
 <20260224013217.1363996-2-derekjohn.clark@gmail.com>
 <478589q4-1rp6-87q8-02o8-n50071039639@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <478589q4-1rp6-87q8-02o8-n50071039639@xreary.bet>

On Thu, Feb 26, 2026 at 06:05:10PM +0100, Jiri Kosina wrote:
> You would need and Ack from driver core maintainers (CCing Greg and Rafael 
> here) on this one so that I can take it together with the rest of the 
> series.

The comments are a bit odd in the descriptions of these new macros, but
hey, it's good enough to understand, so no objection from me.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
