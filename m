Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCB13E715D;
	Tue, 17 Mar 2026 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759173; cv=none; b=rdf2HY3p2fx2Eb5nL8yu9HrfDAjHOBIR3Kb1fInsN5MEfCYEDEYg27n8zNwvsi4d1h3g9zWU3mlDZgdXNS+IkyeFxp2Lj7B3ugi/eO0cXf6VPsNvcZXSyGioEvTbAUu/zgyaQIsgc69M2x5YGnEh0SMBGjIZNos4xRwPP3g1JaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759173; c=relaxed/simple;
	bh=SfvfXamo1O39U77ZOFJ9zsbiZyki58q+42fgco/RDq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G37OGJi4NlX3MRsDn1+FwM40sa4fiykp5Dx2hcbLKWiSpKzO9YuLm7hcjUOwedzeOrUK/ZYsydcxaGXIxNtUD1f8tHFyjf1BahB4+mkwbMMUpne6RTs0+V5WpVejYt9RMGxlxYdeSHeYYgF3AjTFe2OTK7yjCAPm80tOn5fS4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b05rH/Ui; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b05rH/Ui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C504C4CEF7;
	Tue, 17 Mar 2026 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773759173;
	bh=SfvfXamo1O39U77ZOFJ9zsbiZyki58q+42fgco/RDq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b05rH/UiTWknOn68plXDwb9go0i2wbnDWUlyhtjaTpNAWfZzprJ/6c8HFmOUyQsBj
	 sQ5HneWt5/5bj4m8ssx5zeWAQSVMUFAqw7N7CMI1llNDUyJv99HfXDF2NZGnRae+qJ
	 q5IkieQesB5I0K3wApbApLgCVOV0IPaLlN+GhiOOR76btTIH5Y0m66iHzQHjBIfeIq
	 eGvGsmmxJocz/IobteVWQv2MqYuVhgM095nQ9j/muzrfW4F0zOhPSlX6Wy2kQRJFo1
	 7ZKEgx9TYL01gv5+MoKBky8wbzIKwLKU0pEBD88kOfSa0uTk5T7/su2uHUOLZsfQwY
	 52K+rXSvQbpew==
Date: Tue, 17 Mar 2026 15:52:29 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 2/2] HID: core: Check to ensure report responses match
 the request
Message-ID: <ablqdkI1d47xN0LM@beelink>
References: <20260309145942.1496072-1-lee@kernel.org>
 <20260309145942.1496072-2-lee@kernel.org>
 <abghH9Cf5FvUpfE0@beelink>
 <20260317092056.GE554736@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317092056.GE554736@google.com>

On Mar 17 2026, Lee Jones wrote:
> On Mon, 16 Mar 2026, Benjamin Tissoires wrote:
> 
> > On Mar 09 2026, Lee Jones wrote:
> > > It is possible for a malicious (or clumsy) device to respond to a
> > > specific report's feature request using a completely different report
> > > ID.  This can cause confusion in the HID core resulting in nasty
> > > side-effects such as OOB writes.
> > > 
> > > Add a check to ensure that the report ID in the response, matches the
> > > one that was requested.
> > > 
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---
> > > v2 -> v3: Cover more bases by moving the check up a layer from MT to HID Core
> > > 
> > > RFC query: Is this always okay?
> > >            Should the report number always match the request?
> > > 	   Are there legitimate times where the two would differ?
> > 
> > Technically, there is no reasons for a HID_SET_REPORT request to change
> > the incoming buffer. So that test might break it.
> > 
> > I prefered fixing the calling sites (hid-multitouch and others), because
> > here we are making decisions on the device behaviour which is not ours
> > to make. More specifically, such a test will prevent us to fix a bogus
> > device by plainly rejecting the call after the facts.
> 
> Okay, so this one is a NACK?  No changes, do not resend?
> 

Yes, NACK on this one. I've merged the hid-multitouch one which wasn't
using the API correctly, please send a followup for the other similar
cases.

Cheers,
Benjamin
