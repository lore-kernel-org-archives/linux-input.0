Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75405B206;
	Thu,  8 Oct 2026 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791430163; cv=none; b=Dgpckyy2wrKS+1gWpAUhOWIG0BJsiCbI71teIMwoHd1lreNh4eoxhZw+CYPKdknfiEigjRuDWdNQjct4ruyTQBBsF28r8egtPvx+vhku0ZfGAuuUKuR2AEacsHY5PVaGWLjP7lOaQLoPCB8vF9UQNeBrWP9d+lcBa0vs8Yv7ixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791430163; c=relaxed/simple;
	bh=CXQH0wLzHO+w36pWAH/Cz4HngDPLIZHENaj305uQMzI=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=Abyg7MKJsEDh7IgK1AjkXwK8epf1cTsYfbcF1j3cdGjYjL6AxeCFlsSEjKAuBYFDJGW1tuLvQ1lJ0icV8PuKW23whnZj/mS/Jwr9WFPL8926b50U4AnRTLhqq+Vt+S4JK5MtmDGUkJMRj5EqiIXTCD6veRZc6CBpl7TyASCMGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=FCK/8Yca; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="FCK/8Yca"
Received: from webmail.inf.ufrgs.br (webmail.inf.ufrgs.br [143.54.11.45])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 0B2A21210F1;
	Thu,  8 Oct 2026 00:29:18 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1791430158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LpE0JQqo2ds+KKQuW3zSZTU4qsZK99/NWAPSgR4arNU=;
	b=FCK/8YcaTe8xBN2GZ9KxuxNi9ftWGSjwwT2+kIejzBEiBOBIhEz0YQGiGsNzPN97kseYRK
	HigCEiwOhMSk2a3Dj4HycGXBX32/wtpgIC1X0K0nKLi/MGfGbZCED4Ja0rvDOmVwX3EJ+g
	/WMwlUwWo6o/9ufSV+GBDIU6SbWtH277aqnCDTN+gDc1XDh8r1FMx49peEDUTA+50IsPyt
	wVjNDpHcn9AFOQ6YDbTJNu13lny5sdFtPQeLddmMyI92ZztCOwO23SKUJMEWV5E8CLigJh
	eFbeCK0uCEhiA8kWISpzaEAGBTaKmUSePr5qWK7Xs3bAU8YNWnGwW+DmKV9BSg==
Received: from bd06e904.virtua.com.br ([189.6.233.4])
 by webmail.inf.ufrgs.br
 with HTTP (HTTP/1.1 POST); Thu, 08 Oct 2026 00:29:17 -0300
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Oct 2026 00:29:17 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke
 <jason.gerecke@wacom.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+b5a7cd83622c747977de@syzkaller.appspotmail.com
Subject: Re: [PATCH] HID: wacom: fix =?UTF-8?Q?wacom=5Fintuos=5Firq=20NULL?=
 =?UTF-8?Q?=20pen=5Finput=20deref?=
In-Reply-To: <20260924020936.17612-1-matheus.aalmeida@inf.ufrgs.br>
References: <20260924020936.17612-1-matheus.aalmeida@inf.ufrgs.br>
Message-ID: <1e4cd74d1d4598dcb22198724323cf00@inf.ufrgs.br>
X-Sender: matheus.aalmeida@inf.ufrgs.br
User-Agent: Roundcube Webmail/0.9.5

Em 2026-09-23 23:09, Matheus Alves de Almeida escreveu:
> Currently, wacom_intuos_irq() passes the parent of wacom_wac's
> pen_input to the dev_dbg() in the unknown report path. However,
> pen_input can be NULL on interfaces without a pen, causing a
> NULL pointer dereference.
> 
> Get the HID device from the enclosing struct wacom and use hid_dbg()
> instead.
> 
> Fixes: eb71d1bb270e ("Input: wacom - use dev_xxx() instead of naked 
> printk()s
> and dbg()s")
> Reported-by: syzbot+b5a7cd83622c747977de@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b5a7cd83622c747977de
> Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>

Hi,

Gentle ping on this. Has anyone been able to take a look at it yet?

Matheus
