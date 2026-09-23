Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B114753979F;
	Wed, 23 Sep 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182235; cv=none; b=gdRp5YE0SDPx6C/cpPIOr/yW1eND9GbTli5VHs589I8KMDtYOQbmvBSZlkSyQU+cYDnN9MyoXMoJxyXxS+wm4GGZfXAjUcy3RUC3KC1sPGHtzGyLrh6ibzPRPS6R13T787KIJ0rnvgoYhHX2GK5PKtoJctriLYfecJ+rRzkjsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182235; c=relaxed/simple;
	bh=qnhpWcOTUhlbHgo0G5qdKrpwcuAvxyTbIte+678S0hI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f8NXne4aUn54X1KifOiszPNGm+a+ZchcxBnijDj7/nf4LWcBRHKAO8BsAvEaEPzk+6nDUVEPfkW6/NGJ2mUPKCqlxQtsi8QYlzqLxFNvMpEXFm4AP//LPdVQLLUODVNFUCN1/lAOWmL+r26Q0uf+jnpFFS2esC9s5TjwUM/SPFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYYGzYVn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYYGzYVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F911F000FF;
	Wed, 23 Sep 2026 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790182234;
	bh=1xWgHwZWH1TRXZmwGuSO0z6vDIcHiOa1CmXcRsSUal4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=OYYGzYVnMOASN0EcIEvhF90FFbqedcFlwHQb4xuEW621JzNBnRYmwro2N66fb+d+p
	 JkiZjyZAXDiydeg7bHSu7cuKXXelN5aoAoTetAekIqMicm+ldgxQPEwqzyYOjMcx3Q
	 4bfPO2/sAkjSu2CWXnCpJXsi7h7sdR7oR6bqwRcF5myoxUmgGy8tT0m5EY2xp+mURr
	 21UPS5sJCn/iDxV846fcfk+v3mK7IVBSMZkrBHyTw6sSiSt+L2WHHrPqZhq6Xjhtzs
	 Van98rrrEXuuZwuSwvoPRzkNorp0nk+fAJlnajl82kgfj9PtT/4uD6ccT00KZvPnbP
	 sPZPldQ0Ah9GA==
Date: Wed, 23 Sep 2026 18:50:31 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Even Xu <even.xu@intel.com>
cc: bentiss@kernel.org, srinivas.pandruvada@linux.intel.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: Intel-thc-hid: Use hid_safe_input_report()
In-Reply-To: <20260922025437.940072-1-even.xu@intel.com>
Message-ID: <8o1s43n1-spn5-oqn0-38p6-sps024p3p1o6@xreary.bet>
References: <20260922025437.940072-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 22 Sep 2026, Even Xu wrote:

> This patch set replace the legacy hid_input_report() with new
> hid_safe_input_report() in quicki2c and quickspi drivers.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

