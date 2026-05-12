Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BEE397E9A;
	Tue, 12 May 2026 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577930; cv=none; b=lGJee9oez1vcvqk5f4yrrEnz99D0Nruf7k2GGO+ojd4zMCOs4iMarw6CcHm9jsef4ygu/2h9tb14l8Waqkcu/2+62W+znIJ5ccGgbqKebZdqJ8Ji0wTG1sVFABXTEvBfXY/BU1OhzGHWXNZhPHUWxkEuztsa0+QjUBMkUz3LG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577930; c=relaxed/simple;
	bh=PEcrkhRvQfp4zqVsu9MHIAZTQ7ZDryy+9J01M/if1yU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8F5A9Eb29ZP1N6qKCRWa4FZAhyrY4PcK9JyP/ep/BUHAfs5Qw8eJ6zybGz352KmNDpQqjcmaFa1nKXCpgzUeLWty1T8C4ifN/Zcrt5scYzCt2lCelvLz93JVky7huj84gj/siS3ADnNVG+zWWGIVLvWvCfoF4qg+a4PJS65vZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hEs0ug+7; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hEs0ug+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778577907;
	bh=lzHr1CSKQgNBUz6HXKYaUbnLWBY4AfySxLQYb8vlGnA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=hEs0ug+7V8CrBwa2bSvZ9A0LokkNGJDntABvRktwT2WGwdBtiWyldYkrWmK5jHndw
	 PiyNikWFhK6O9jlza4gZdWt9WryVE0+Iealvjd+6FMY67aFZr2g3BQ5C44DMh4BcWT
	 XSJvhexIe1Q3JlniteDwiTjhsCe98CJOSygQeYlI=
X-QQ-mid: zesmtpip3t1778577892t1f6e98ae
X-QQ-Originating-IP: UkJpUE9wWyltV+OGzk9v1CfdDsDfxoDUssQiPkLhKk8=
Received: from PEN202512010004 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 May 2026 17:24:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12601772386150056505
EX-QQ-RecipientCnt: 5
From: Xu Rao <raoxu@uniontech.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: Re: [PATCH] ipv6: addrconf: skip autoconf on unregistering devices
Date: Tue, 12 May 2026 17:24:50 +0800
Message-ID: <8C8DBB6EEC6528DA+20260512092450.147826-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NMSHCeFjyxDuNMBdTDa+EUIL5sSNft/Ktc0BAbi4PE8DIS+Wi22f7Qes
	DgfZw0FWejgC1T2nt/ErmX3ExKrT2oWAxcccJbVrQsi/Eq+96GC6ShTsEpE4hJah8BjHEti
	BrHtyc6NYm8uBaJtKOsoK7C7MOTXRUfEFwia8kqiAMzAygVXzcq6XHK+AaU+LJ+221U6MQb
	edvDGIEkbRgQuZZIFriyBDf5gOTvKpPjUm5Lf7TykGFbOk5rQcNKPaYN18U/0RrL7l/imVY
	8xh5F0AOn8uLncLanoBi3MU4mdpGOzFoPS6ggiYJmgWpMy9vcrhgqeSZs+7EcJHOAa7UdKf
	97FT9soo/RN2TPWMvaUgRymqeIbTZosrAlvFpUVcC5qmLfo1KZkbW60pikyUQuaVDl/USUx
	ppTP6lwoXspRvVqYp5jHpxF5qch/Xdi6oAGezdBeuKzaDTeSOiWLPBONThw7G3iRfPxte0n
	zEXmLIH7jWqs1BZL4Mlhpd3Jc74mUMelwPaOg8OY37X9EL6DBwlFRUZxcEWXbei+dJe5Fss
	1vIo3Lz0d/QYxH0a0kCXKxmgK7AcjJZEflVaTvxCJF0Epbu2x05IVh09PKwLvly/sSpG/i5
	5RPBgcfgH8VVwGKvzS+4n+90mcC0OVQucuko3PjtoS3tgHD0OM1aFhNc3cBp/rln3c2u+i8
	WpN7ElONs+7rbrY8InaSVePy4UiIvh9cU95SvdXt6tVmV1EZSju1jN1l9qAWNw7VgXfFoxe
	v3vMvdPLeKLMvDG68/wwylgV4W150ZBfVI29k0KuFXmIt6hBF6+z7hbnAIHTjetNp+uYT9a
	dJj0z3eKIyztSo7ujYjd4thX311/vdzBpLQnJyibrZNo8KFJQHdO5UiNZKClcZ6gM6u4rjq
	2alCpfF1qHlIQu4+ByIZeVPnC1T13iMRn0dxDn7LuJ0csvHleRocgueAnwEY3sBuz2sZu+w
	ccIkLMsfR6VoxEHeL+uzW8M4282NgVR61Qza9AWbC+Sl4OYNsko55UlUBBXTetXw8vkH8La
	Hah4tT+GbVvc0PwX+DSsl39sExERc=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Hi Eric,

Thanks for the review.

> 1) I presume this targets the net tree, rather than net-next?
Yes, this is intended for the net tree.  I will keep the subject as
"[PATCH net v2]".

> 2) Please add a Fixes: tag
I looked for a Fixes target, but I could not identify a single commit
which introduced this exact bug with enough confidence.  The path which
can create an IPv6 link-local address from NETDEV_UP/NETDEV_CHANGE is
very old, while the failure depends on an unregister-time race between
rtnetlink flag changes, addrconf autoconfiguration, and netdev teardown.
Because this looks like a long-standing lifecycle gap exposed by this
race rather than a clear regression from one commit, I did not want to
add a misleading Fixes tag.  If you prefer a historical Fixes tag for
netdev requirements, I can add the closest addrconf change you think is
appropriate in v2.

> 3) Why READ_ONCE() are needed there?
I used READ_ONCE() in v1 because dev->reg_state is written with
WRITE_ONCE() in the unregister path and netdev_reg_state() also reads it
with READ_ONCE().  However, addrconf_notify() is called from the
netdevice notifier path and does not need lockless access semantics for
this check.  I will switch this to a plain dev->reg_state load in v2.

> 4) Make sure in V2 to CC netdev@ mailing list
> 5) Please wait ~24 hours before sending a V2.
I will also make sure to CC netdev@vger.kernel.org on v2 and will wait
about 24 hours before sending it, as requested.

Thanks,
Xu Rao
