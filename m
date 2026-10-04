Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76F713957E
	for <linux-input@vger.kernel.org>; Sun,  4 Oct 2026 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791126226; cv=none; b=g4U+VMQtuAVrFiKWWQoVUAlhhKnHTy1OGG1+35pNX1Q8qZYGk4CnRCwl9Mpn8oRtGnr0JZB7WdLpfeDj4Ku0EVQE6gQ6qdRxsnZyYWR62vJq9JlS3x2/I/GeZQKFT088PEThrGLt8OOpyrVawdxCjM7t4RLTELB7sCT0RCp582U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791126226; c=relaxed/simple;
	bh=CiRhmWHd0cPh11bw7d31qGkBuhxTf1tf2va+V34flW8=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:Mime-Version:
	 References:In-Reply-To; b=T0z3y2gD/ayzWUPnToi39qJWD5fYGJOKr9xjcYHfYD3qs3J+koS4uuYtOOzoZfyfLQJghdmyl248AurSCgcX6VpRkXyJjWkMBw80l5MfO8MuaDMFdBea9Q5K3UALxGhtyoyqhyyowpr403EuuDtCc+w5OJ1mHnYnLe0OTdo2G/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=Xp3woSjb; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=KOcLHhrm; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="Xp3woSjb";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="KOcLHhrm"
DKIM-Signature: a=rsa-sha256; b=Xp3woSjbJd0uDV8bOtIG1qBaFZ0GBTsAuOkm5LBVMz93XpVwWKf0WUMM6UiqBzAmFDHOvhunNPtP+fTaMMaBu0Nieid0+pp/jg4gmlFWXwfNnSV0Lg2SutcKBy9SPqNKJs5j66xCu+gF6kCCM+6PxjR2E7xoCvqYrx7fjWYR18KzL+GILNbYnKvrhOt3RsdrInAILBnfBfQQHGBRdUsdNY+yu7A9Yc55ccEgzwiM21hqkioG9JTwNM2jG+U90+ZqGGqeFuMeODhkoFfwdqv95pvRL8SAdf7nNGf/ukusPLpTd6QkpvBPalQ8C0wcJfhcP5Cmtc/lKHpEUpLhGsmumA==; s=purelymail1; d=rcpassos.me; v=1; bh=CiRhmWHd0cPh11bw7d31qGkBuhxTf1tf2va+V34flW8=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=KOcLHhrmlx/dUVbdSTAgWS7WiZ9tAqWbuI+Z58vDBEPLfBJcW14qt2bgXhDWPFUQ1GVA1Iozi4qTx6qhIoCOYv+65dBbnYLxfuGfjvBRqcDR0NJxjcNcZH0YtCyXUEduYnIbFXf2VVFqHMy+ZqETNP2XaXmioQ9UsaMDr5AvPHiaaNIaOa7gMS7REHJVtnpSNMnF5S6RiKE2h71QlbHoNVd6DQTsQMrLz1QP2ki1mjb6rkfKI6Hvhj9xkvQ4G28gF2eBJw8O47DhIpECVpISDj6JeJBOwF0Kr4QgBdLjTVDvRslQGT7BcXZGSBHiVNKBU0QChkz44dTNdDExrWZi6g==; s=purelymail1; d=purelymail.com; v=1; bh=CiRhmWHd0cPh11bw7d31qGkBuhxTf1tf2va+V34flW8=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 897848136;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 04 Oct 2026 15:03:20 +0000 (UTC)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 04 Oct 2026 12:03:46 -0300
Message-Id: <DLW5992OONY6.69AKQBHWGQ01@rcpassos.me>
Subject: Re: [PATCH v4 4/4] HID: wiimote: wiimote_probe with scoped cleanup
Cc: "Shuah Khan" <skhan@linuxfoundation.org>, "Brigham Campbell"
 <me@brighamcampbell.com>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 <linux-input@vger.kernel.org>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "David Rheinsberg" <david@readahead.eu>, "Rafael Passos"
 <rafael@rcpassos.me>, "Benjamin Tissoires" <bentiss@kernel.org>, "Jiri
 Kosina" <jikos@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.22.0
References: <20260817213840.1053216-1-rafael@rcpassos.me>
 <20260817213840.1053216-5-rafael@rcpassos.me>
 <efe87355-ad73-401b-b236-18eb9e398498@app.fastmail.com>
In-Reply-To: <efe87355-ad73-401b-b236-18eb9e398498@app.fastmail.com>
X-TUID: EG/gT6uoprUi

Hi David,

On Sun Sep 20, 2026 at 5:21 AM -03, David Rheinsberg wrote:
> Hi
>
> On Mon, Aug 17, 2026, at 11:38 PM, Rafael Passos wrote:
>> Use the safer scoped cleanup with a single destroy function.
>> A new bitmask was introduced to track probing state.
>> This is needed because the hid_hw calls cannot be made with null.
>>
>> A few other functions are safe to call without checking.
>> These cases are annotated with comments above them.
>>
>> Also, a new debugfs entry was added tracking this new state (bitmask).
>>
>> Signed-off-by: Rafael Passos <rafael@rcpassos.me>
>
> I am really not sold on this. This does not make the code any simpler, do=
es it? IMO, the goto-paths are much easier to read than tracking the state =
at runtime.
>
> Do you think this makes the code easier to understand? Am I off here?

It does not make the code simpler, indeed.
For me, it looks easier to understand the possible states
the driver can be in during startup.

Do you have any suggestions on how to make this simpler with scoped cleanup=
?
Otherwise, I have no problems dropping it. (It was still fun trying it out)
The rest of the patches are ready to be re-sent with your reviews.

Thanks,
Rafael Passos
