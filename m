Received: from mail-200166.simplelogin.co (mail-200166.simplelogin.co [176.119.200.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F7226656D
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=176.119.200.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972440; cv=pass; b=py4TzYxzAL9/0SLAtyq/GDuMG8ITwrm/O3lsTZkwoDZXwsYrYTf8KBFIeTymtIUh6kkpxzblQGPvwKrh0gz8L/GZJkhlO2qjqMYvo4kiOlVH7q7UjIpv6d7H/lUJPnxqpZD5T/qibGMKBbWpS844SaHO8T/d7N5w8pUk2Sy8c0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972440; c=relaxed/simple;
	bh=pJXOrS5KkytWx0IURurZkjbGtNoE+mk23vBrwaod+fU=;
	h=Date:Subject:MIME-Version:Content-Type:From:To:Message-ID; b=lYtZC6aIoDvIu+PENolqDmbENK6jvD1sxApMSEWukLtfe/YyzZpUS3PARXVu8RARSMPhB/+wrpcl2Nvt0XSZdTPnDg5+90kpUwOAFUBHpXQ8yBd6VXcESGpRDDgY08o6LjRrkqUqoANh/3/hU5ot9p+NbYUSGz1fu+l5mpDGcIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=passmail.net; spf=pass smtp.mailfrom=passmail.net; dkim=pass (1024-bit key) header.d=passmail.net header.i=@passmail.net header.b=uP5nK/K7; arc=pass smtp.client-ip=176.119.200.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=passmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=passmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=passmail.net header.i=@passmail.net header.b="uP5nK/K7"
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1789972431;
	cv=none; b=hR1oztGYn92Ny2Y/ecshlMdLaSeKlQB21Z7SMhBOnAAhNWaOsyqTNncqNBmqXY28ubc7QoYPS/rFt9becYXJqGsIu+ZI6hpKYlBAekOdDzTu1kS+6uXSD8GEMimwz3SELYdzgq+YkJaiHgNdhXuVpxUuVVM3j1smz8YjHOoIJBtmYKM5aE9upxDW62SaA4bWstYchQbc7duUhlDZmiiISYG6JFr4tAQWW5snsWEBIQOnXtfvs8QNGaWRuNqiOWURLnAKntzBGOomSloSEL6GWCG+KwhvhuFD0R5wGQVglbLvTESuAqy3+zboe0BA3YyI6Kc0it60N8hnWOSSrMIe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1789972431; c=relaxed/simple;
	bh=pJXOrS5KkytWx0IURurZkjbGtNoE+mk23vBrwaod+fU=;
	h=Date:Subject:From:To; b=uQQpgVznbbwayDBUCywDEuaY641r6DAu1BJmqEq61FhvVypFo8o7Wjb8rTG9ofSWwWm3a1TjVxit42dqiTRiipTVMUvwhtNELhpMOI5hA6vqZanjiqMQKxMYJl/xxWU5dGmad70ltUlnZZl094WwnHUjmKe41Uqjji+F19eG8BoNFzFRdGcXuR8kYikLgx0ju4E3r/qihSBsDik7iNfX3tBi8iWsnjvHYORPtqYb2pLZEdH+yOsL8gNBjifCdJW6mIiQhDVxJMsh2sSzn2JdguemX460JyG1RNykndL8MMwFeswUkGuoEstNU3wIqKJ/a0TntGhpcaWKuciRj1EN3g==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=passmail.net;
	s=dkim; t=1789972431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pJXOrS5KkytWx0IURurZkjbGtNoE+mk23vBrwaod+fU=;
	b=uP5nK/K7QTccvSd+ZpULnpJs9DP+zj68sUzKPdlVdyI65nTyNPptxVrZPqpAgycfDKIo1D
	pRYl1R7LM5kOBZMni+/mOZ4LNsklU71BMhE7NgrLNf2Xg9mCienoS7LmhcmY8FP8uOOpYM
	GIOHOVmZlWPlhi4pFKAFjav5FddCJ4Y=
Date: Mon, 21 Sep 2026 06:33:45 +0000
Subject: Asus laptop keyboard does not work before root is mounted since
 kernel 6.18.50
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: alpine.skilled126@passmail.net
To: linux-input@vger.kernel.org
Message-ID: <178997243101.6.12274125017298403957.1635411565@passmail.net>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1635411565
X-SimpleLogin-Want-Signing: yes

Asus proart p16 laptop keyboard does not work before the root filesystem is=
 mounted. This is an issue for me because my root filesystem is encrypted. =
This dmesg message is present with the newer kernels:
asus 0003:0B05:19B6.0001: Asus failed to request functions: -75
Reverting these commits and rebuilding the kernel resolves the issue:
d0754db7883c HID: asus: simplify RGB init sequence
8b5debb6252c HID: asus: fix missing hid_is_usb() check
Environment is Alpine Linux 3.23.5 with kernel 6.18.52 x86_64.

