Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922822FD69E
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 13:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826668; cv=none; b=QV5WuaDDg3VPnkO06QMUuwGOGTscUKuO8/vTEe1MzLGPxnVH35CRnadC+kSA9Qu2bxOidFe+SVFCy4o36LGFIaD3N40o2XjgEwQ8nVgcuErXX2mkph/+OlDdMetbzNo0cNUtPbVf40qHcAq2CWd0AIAxVyipMhy5Z5SmzGpgfHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826668; c=relaxed/simple;
	bh=4T7Fo4wY6aOVVhWIMKTnP3mxbTT9YFU83DRl0UX7/Dw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DIlGXRaoKa15MfUiI+jNnPBG2lKLF/Ci+0qxNKBLCR1//l/K0zoqBvWWhpZWGZ0FmhEKf+Uxpm7snOIiFPCQp6oCHZWfiomnYrOVBhQpfPv+WLTNx3bwhN88vigpQ5Qiwoxn0g24dOZGv7Tk2lLBe6RcjQdeSUw/igrCp1gnfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcfWGDAc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcfWGDAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DA01F00A3A;
	Tue, 30 Jun 2026 13:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782826667;
	bh=/zs5Iv7GJvcNWvXPw6qW1n4MQ5ky02ZMuvMnshCVi6c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=XcfWGDAcbHNd/uUljT5ON2ON3jRN4qNdocJ3ks/JPygQvVikFJfPgBI3vy6qj/+rS
	 Oo0X2FFzjy+wT7OOSIe0bDx+5f7LYo8OIOluYFz8iqv8ZfzFeVgddgvWadMi5QUPzW
	 KyL92STOckA+Wj5dJOgcGO7QwqAttn1yW8Mf9M4ZpTq89msn4+7H8ja0ZXuY9/KAme
	 iK8pIGwC6wvQSGut9IzcA+zhAcmNEH0CE4CskDcsa/7wI5J8qL14XjWAx1rmfjwXLF
	 vszbgJ8v9HEqpja2NOCRfFJe10IQYMD1QFhOjAC4H1XHiFc2FSRocd4Sy3ey8MwOCv
	 0oM/Jw6cPb27A==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2813BF40069;
	Tue, 30 Jun 2026 09:37:46 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 30 Jun 2026 09:37:46 -0400
X-ME-Sender: <xms:qsZDapiaB62VBfdiJQYDgCAgVuh3sgmyrSGDXDw39RaKzTPz7c0yPQ>
    <xme:qsZDao020LAf9dEBA4Gn74L1dwP7lyuKn-ax37KWbDhwBULYkRNOBlKEhKDx3lR_A
    jkUASFZa0HtqW7CgZyFccMlNi3dZwZAlfy_XY4Mt3vfl_I5NXE03g>
X-ME-Proxy-Cause: dmFkZTEn5jyWc1L7F3N8BZLsS6yg+Oe8hPjPbLsf8Mv3b1EOGtQFMvpIRUfiz6EjIyp+kW
    4QTJ5Ypr5hgyog+gW+AGGysE50KIGm2ccpk6tuqb8kjwJTQ+tL/mbsm5sDtgczMNkN+8/B
    X4wxgwEgRmwXN1o3cw4fNxExNQeaBQLU8bpC8oajXDXaVax+6D4lIm2vnJKbRb8jou+jax
    f99BZxx6NG+OTV/uV4JwY0MmeIINRadKhU2GlIO8Wme4oyqCEu70bN00tQvbhPSUQJMrNp
    590p+TE47JSxyKxqzL91WxBkKXxpxVF/Nse3Yqepg3mGVdxXUBcLeShikiuPkU0nHK8KhV
    Pcz9RmK7zuQ/IEqY/CFDrjYYrzYIOgkw9A72DA6A2YJZZ7ZQnSJDqIMW7nPcFR1kSqsrZ9
    bwqo8aQ0cCEUWy2Wg7ukYzz3Z3TUlholvhEZB3OaezgSYDz8OoQAWQ9bCNLAkuNBCu5na5
    PmkcSz8CRwuCdoV4Hifz6R0dR0p4KP8q3CfppWUwgKYGAOUgO6fk1jiL8N0SYh49BoCsUD
    cfJphx5e8jHZ5r48XrC7dqBYxOzyIWd1rqHT4SdCzf5t+2xA/qsAeA2VLdXMGO5z6g9v1u
    ehceMVpg2urAVCVueDo6k7gXRYVvE1rBITMewk6f2UHioOZ0QJuYtbRTzzsA
X-ME-Proxy: <xmx:qsZDalcRBSBdjio--IHRqZ6qG6q_ZJUHu-52p4vB1Phdqj3ZuvuzEg>
    <xmx:qsZDaoJBfaszMYC-PaaW7yy_PoQjBoKmEy7oHaTndzAOQbN3Lor5QQ>
    <xmx:qsZDaizghy65xDuTI22p_x7J_R850tJDLXE93ctdDkkkGfdC4toFrA>
    <xmx:qsZDauuwc8XKOvag0uOUq2s-3WYY9T8DBE_F_aUlACCW9f4M0cfkZA>
    <xmx:qsZDalBy4K5p5L8Zz2ie_w0K2-3Kzgre-iBG5mvNbt1Zn1EXpkAc3hul>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0E167182007E; Tue, 30 Jun 2026 09:37:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Awr8XjsC6ZY3
Date: Tue, 30 Jun 2026 15:37:25 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>, linux-input@vger.kernel.org,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, linux-sunxi@lists.linux.dev,
 "Vinod Koul" <vkoul@kernel.org>, linux-phy@lists.infradead.org,
 "Vladimir Oltean" <olteanv@gmail.com>
Message-Id: <754363e3-107b-46ce-9d0e-3398845a6121@app.fastmail.com>
In-Reply-To: <20260630132842.39AF01F000E9@smtp.kernel.org>
References: <20260629132633.1300009-1-arnd@kernel.org>
 <20260629132633.1300009-10-arnd@kernel.org>
 <20260630132842.39AF01F000E9@smtp.kernel.org>
Subject: Re: [PATCH 09/13] phy: replace linux/gpio.h inclusions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 30, 2026, at 15:28, sashiko-bot@kernel.org wrote:
>
> [Severity: Low]
> This isn't a bug, but the replacement leaves us with consecutive duplicate
> linux/gpio/consumer.h inclusions. Could the redundant include be removed?

This was already reported and fixed earlier, all of these will
be addressed in v2.

     Arnd
