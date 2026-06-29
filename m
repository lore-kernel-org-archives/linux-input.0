Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1843F0A92;
	Mon, 29 Jun 2026 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724310; cv=none; b=VHXu3oYhRn/S0QFt35gStHlkyE7yRCcs6fs7PzmuqiLpVv9QvzemyB9D2xj1mZfFpjlmWpS7W2flnzk5R/oKNmoW1LSQUjvFCG1cvwBl51FrSndUDbVHIZ+7xojq75nAwPqRL2iCaB7u6ikND16lCr0UBDvYnvI0GgcLPd7+orA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724310; c=relaxed/simple;
	bh=8qe6bvHg69kHvXEsNbXclQ4tjxp6xKRaS3OjiOLXOg4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OEMu0P1pv8NoAdV9TRrPnRAf2pSpwHG5bkoesEynCBycCx6bWl5I10NB55BgLe+JLfgDKP7hysHyVCpqB8c67ruXLA8Mp1DY1ll878H6BSvf9zTjcGNoAPX6c7kUDjVNDPQVUjxGEFO10H3rhDyeBvPJnrdnwa973pHnqS6R3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOgGJaTy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOgGJaTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A641F000E9;
	Mon, 29 Jun 2026 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782724309;
	bh=V840BXPOwziR/7/4JzLB2CvI7GoiPlzkINI/Y63Ez6c=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=bOgGJaTyTD6fGP+LG8nvkA1ZIAr3e7oVpyjAP3nbnxPv+nlR7Pf8R7+5wTn2JlTnk
	 mhiZxuYMjiXAlFovbxw/y6DSUFVCUy2BekaNKB5visbf88Lq+Im18vCinN/azR8ON2
	 23Csn6pnjrx4qLdU6OXnlIpVWC3jqaLNDdOVgXwiq9GWYbEn21YrB8Vrc+dlrVnZqo
	 LYmCHWLKc/AmYy9P4D3LGZxIiELKrZKASeSU95husGHai4ESBZ9pN0Su/saC4WKPoG
	 SaQa3CGyVejyy9qYW8eOwXYXacra2BozxfjDMYCYoq10FPjgqg2kz4kUPkifex92hf
	 PM7sp7PLPh/WQ==
Date: Mon, 29 Jun 2026 11:11:46 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] HID: sony: more cleanup
In-Reply-To: <5o965110-3959-0061-1s41-q7224452q746@xreary.bet>
Message-ID: <5opq101n-0prp-r219-s695-on18n7478201@xreary.bet>
References: <20260616205042.6671-2-rosalie@mailbox.org> <5o965110-3959-0061-1s41-q7224452q746@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Jun 2026, Jiri Kosina wrote:

> now that this is sent as a series, I can easily apply it on top 
> altogether when the merge window is over.

Applied to hid.git#for-7.2/sony, thanks!

-- 
Jiri Kosina
SUSE Labs

