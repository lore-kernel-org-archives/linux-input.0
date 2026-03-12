Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491A52F8B;
	Thu, 12 Mar 2026 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320614; cv=none; b=CbvKNeE2xjJgbmkqo0xIGvSmN7/KW0cNIksFzqq6w997Nb4xEnL5U5lNSi54D4DvTeR9xDIqNECBy5W/QvvaSd8atF0VGExt+iG4VpFoVkVad0mW1+rUrZGyq0xlOb8MwWIoIT5QXJfxG2P54w7OlT+oWDF0j7EwqKIP7AxTfKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320614; c=relaxed/simple;
	bh=G/GvL49Z4wjmBDZ0WLQju4xrr5nQMe5GTTgsCS9txOM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=opmk9SAKDIwGot0Jt3s1TjuNo3f3igXyOGntcFjWyNJLMN8nMl+gZhdi/hrjhykStB6PkWkTl3wSUrokHSqWEQs389Yz+6cQIzLxvC5GCjjPB7rLLG9OLLtfdg2NobZzF9C5B8t+5q9vdnOg08miLaTFAjnQ+etZ11e5qSeZq4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/lZCdRk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/lZCdRk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08CFC4CEF7;
	Thu, 12 Mar 2026 13:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773320614;
	bh=G/GvL49Z4wjmBDZ0WLQju4xrr5nQMe5GTTgsCS9txOM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=M/lZCdRk4LUk4OXpeYyXZ71PPnscUaHz9LdHooQxPDhW39JsRELHIS4OgbAKxUuxH
	 iYQpHsR0NP/8ygsagz+j3hq5f6YYqnjF2YI3mXPIJ067uRghhSIMIi1VApV2/m/tu6
	 cc5/gWfEv1qv25knQH/65ydMnsWDK6JZygpBcjhRz1aovmMuiVdfl6xZnbE5DxDBBi
	 tzB7JN0tMyJz+bLX3WudQ64om3Xo/bVi9tVCo2t/BwGbM1eftYG4IcKySyHGyvOpSY
	 mn12SHehBTPyG1O+/4kC643Gq+1a5KNUy+u0ykkp+iXWXtnbp3fn+sC3ZKxPsc/m2s
	 gPsasc7cJh1Hw==
Date: Thu, 12 Mar 2026 14:03:31 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Aditya Garg <gargaditya08@live.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: appletb-kbd: add .resume method in PM
In-Reply-To: <MAUPR01MB115468D46765D7DF8C2882B4CB86CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <qn346258-8p42-38r5-86r8-8n1r87204319@xreary.bet>
References: <MAUPR01MB115468D46765D7DF8C2882B4CB86CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 17 Feb 2026, Aditya Garg wrote:

> Upon resuming from suspend, the Touch Bar driver was missing a resume
> method in order to restore the original mode the Touch Bar was on before
> suspending. It is the same as the reset_resume method.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aditya Garg <gargaditya08@live.com>

Now in hid.git#for-7.0/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

