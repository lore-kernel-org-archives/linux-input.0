Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B48A364948;
	Thu,  9 Apr 2026 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748470; cv=none; b=nAlz11xhfvbwfdHD7e0k8CjgAmR7mqMu8xY55kWIZ6Odgkm6GOJ9Fatd5+hE90MZ2kesElihi8juYRFh6ifIIyB7e2WZpggCMp9DMss12IO4p0Bpp6RCYSpHgKCpfuUhRL2d6en/HIw2NBRfqPeGXeKvDSYsw93iZefKb5goFTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748470; c=relaxed/simple;
	bh=2fx7AUvdDLc61YLD6Ef4LYkCTwgdfbTrrPipNs4l4tQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MfcXjWV0pjJvslG+QRP/zMbkl+Sr+h//uY0B8BZnV6oXz5oyBTF8d4bBNOsH+fytSRnxd9LhNJQ6tABmktUOS4e0BHdupHDI3TOnK7fPYS16IKSRzMAOPAR7upjko8OQoqmWdhxFH+g5aFLg76M792gfsd7fJWMiHhvTLjGpInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpDyOekt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpDyOekt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136E5C4CEF7;
	Thu,  9 Apr 2026 15:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775748470;
	bh=2fx7AUvdDLc61YLD6Ef4LYkCTwgdfbTrrPipNs4l4tQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=hpDyOektF9ZahDPbmZ1mJVFSVGfu3iwECkJZP/sjHIWNlv3uBJXw4ecRmbqJW9aSF
	 ivSsoTe/cN8wAEVE9QpPHIaxhRjSEZWa/s+AKdJTxcAzKq8annDEmeEanHR4Rj3D0E
	 R00kxJA5M+YFspwx2unmz7+h9mOdeT5mIQJWhBdEZ9meuOoLGjAUWfY+NaaL0FWYCL
	 N5CuXroC8yfUz3PSMrOEk2ocMMrTuiHDz/U0kx5M9LHF7wfA+fdq6GWNNFwqDrvcSS
	 ouAAChcYM//BEl9wJntcPVQKkLGH89NkCm2BHo0LpOHg7q931y9A0J9y1gE6HNISQR
	 xGAmagZISX3iQ==
Date: Thu, 9 Apr 2026 17:27:47 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?G=FCnther_Noack?= <gnoack@google.com>
cc: =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, 
    Benjamin Tissoires <bentiss@kernel.org>, Lee Jones <lee@kernel.org>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: Check bounds when deleting
 force-feedback effects
In-Reply-To: <20260331074052.194064-1-gnoack@google.com>
Message-ID: <6o02srqp-oo00-q0o6-pq2s-o2n1603q0rnn@xreary.bet>
References: <20260331074052.194064-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 31 Mar 2026, G=FCnther Noack wrote:

> Without this bounds check, this might otherwise overwrite index -1.
>=20
> Triggering this condition requires action both from the USB device and fr=
om
> userspace, which reduces the scenarios in which it can be exploited.
>=20
> Cc: Lee Jones <lee@kernel.org>
> Signed-off-by: G=3DC3=3DBCnther Noack <gnoack@google.com>

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs

