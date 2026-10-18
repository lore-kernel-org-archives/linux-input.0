Received: from mta1.migadu.com (out-246.mta1.migadu.com [95.215.58.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D9B339388
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359970; cv=none; b=IdAWbH0/3/WVuK33cY8kMlwMP4dTCyJiA3hqkZHdeblRS5ao6lNYSHG1cqoBcAr4x/VXqFeNdfK74yPTxRas7mr5QDLqrvlOBkYuuYItGTcATCvxY1tm7++rqQd7iCF0Atik3B59XXGd2N2tR8VaF6rsZQGSYcbW9riWJ9erYzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359970; c=relaxed/simple;
	bh=NjCOLTZu1nSUf2FjueDZX20TCFOmcn2JGIuE80qyhqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dGiMjHmUryQMpoeVyxS4OPGOFzh94Gi3+Dk7i7Mn+eVKKMVOFnFfITuHS1J2i7saxhQlxnQiP6BEz095DAS9zZ81K01tlWgp7Zv11ltDSRVRQF+a8/z7qx1mraKCrd1LsPplRvYQ3y+wCQAVMEDUJHLcKS4fQbTNqUbAbdZNMzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CQfQsvlP; arc=none smtp.client-ip=95.215.58.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CQfQsvlP"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NjCOLTZu1nSUf2FjueDZX20TCFOmcn2JGIuE80qyhqQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792359966; v=1; x=1792964766;
 b=CQfQsvlPwNxnhmUMPZh+qpGRn0G81VQqzBiUzVQps+rCd9B8sMx3DqPC44QlJ6AI+cL63gcQ
 5gbq6ZNqeOgYVyVugGbArgm6g6c5x77xFHmWyhDXhao6udNdkX5emuq38fwgxisssM/BKaVpvHu
 oLPBcY3uZ6WjOST5meMMGgeQ=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2cee8683f1f3eb32;
	Sun, 18 Oct 2026 21:46:06 +0000
X-Mizu-Trace-ID: 2cee8683f1f3eb32
X-Migadu-Flow: FLOW_OUT
Message-ID: <4ae775a6-7e3a-4e8b-8da5-43cfb3bb3e54@linux.dev>
Date: Sun, 18 Oct 2026 23:46:05 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] HID: asus: add prod-id, quirk for Zenbook Duo
 keyboard
To: Nathan Chancellor <nathan@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Luke Jones <luke@ljones.dev>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 Ivan Levchenko <me@livan.pro>, =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?=
 <rebecca.mara@posteo.de>
References: <20261013104033.36079-1-p.pisati@gmail.com>
 <20261013104033.36079-7-p.pisati@gmail.com>
 <42cfc8c8-869f-41e2-a58c-0d6c5ce4a6ba@linux.dev>
 <20261018214326.GC4068315@ax162>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20261018214326.GC4068315@ax162>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/18/26 23:43, Nathan Chancellor wrote:
> On Sun, Oct 18, 2026 at 06:57:16PM +0200, Denis Benato wrote:
>> On 10/13/26 12:40, Paolo Pisati wrote:
>>> From: Luke Jones <luke@ljones.dev>
>> A piece of mail header opening a commit? Never seen this.
>>
>> I'd say remove this: that this comes from Luke can be deducted
>> in the Signed-off-by.
>>
>> My question is why has this not been accepted before? Did I miss
>> this while we transitioned maintainer? If so apologies.
> This is standard git send-email behavior to signify that Luke should be
> the author in git when this patch is applied via 'git am' but Paolo is
> the one sending it. If Luke originally authored this patch, then he
> should proabably be the author in git history, especially since the
> signoff chain would make no sense otherwise.
>
Never seen it... I ended up with the From: ... in path text so maybe I
am noticing this just because I did something stupid.
