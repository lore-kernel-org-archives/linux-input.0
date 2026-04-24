Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26689335562;
	Fri, 24 Apr 2026 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045884; cv=none; b=gd0/mGE6vmTl8mg8PbKem59jWbPrXop96piP+fzKhdsOm9DXFGRDu5ADKvQPMn29Z/HE3SI9sokuJv4AEqj8iTvqbHA3dVJJWgXbQGaXlaq1nUSeaceUNfNttwvPhxIXNNtuDo7GpjYJGMHI7deOsgKw+9StiqAu58k50JdRxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045884; c=relaxed/simple;
	bh=GDEkh6e8UcQMil7JgrJEx7RjsOsdcTQSumcZJQ8HnOE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cyktaXvWsTEWeB+xEZxOVer/21G+R6wwRAfHfEeIZik8riHWx4aLSk2Mlz1ylXSaq0jsHOLetZtGDY8qrBjDdLXNWKRq/qOK7fETgqrssWo54hTWZr8ORkM02BfKZrn5zDmLeM+q+1jmBcs99BCPMukIaf80sdHurZO1S+Ecwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=D7L7TRv9; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="D7L7TRv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=GDEkh6e8UcQMil7JgrJEx7RjsOsdcTQSumcZJQ8HnOE=;
	b=D7L7TRv9wS8OlWLkmbMjdJ963bcgvNVjZbZ7VceaiuAW6iWtFcvJ07iOLH0W+9
	WeF1ODHu5ug44v/4aW7lulwcQafMQTZhdiWJGBft6PenlMC8WQY7ZUlZJ00rUe9z
	11wrNGNJMN8bHRxEPQmdL3X1LjDGJuq/R3B/2DghuiF0M=
Received: from ehlo.thunderbird.net (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3p21dketpeGf3AA--.24886S2;
	Fri, 24 Apr 2026 23:50:54 +0800 (CST)
Date: Fri, 24 Apr 2026 23:50:51 +0800
From: Zhao mengmeng <zhaomzhao@126.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_HID=3A_bpf=3A_Sync_KF=5FSLEEPAB?=
 =?US-ASCII?Q?LE_flags_in_hid=5Fbpf=5Fsyscall=5Fkfuncs_set?=
User-Agent: Thunderbird for Android
In-Reply-To: <aeuDkTryZfgjzdcS@beelink>
References: <20260424-btf-define-v1-1-0f52dffad5aa@kylinos.cn> <DI1FOWOLC37Y.3DK99VJZDMWKI@gmail.com> <aeuDkTryZfgjzdcS@beelink>
Message-ID: <DED11F1F-58D5-4154-B314-9E61FF3A0C74@126.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:_____wD3p21dketpeGf3AA--.24886S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw15Xr45Cw45Ww4xZFW3GFg_yoWkuFbEkr
	4kArZ7Cw1Dtayqg39rGry8Zr4jqFZ8GrWfA392vr43ur9IkryDJF4kurySvr18XFW8Wrnx
	GrZ0q3ZIy3sF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_1v35UUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqh7QSGnrkV77ZAAA3+

On April 24, 2026 10:54:45 PM GMT+08:00, Benjamin Tissoires <bentiss@kernel=
=2Eorg> wrote:
>On Apr 24 2026, Alexei Starovoitov wrote:
>> On Fri Apr 24, 2026 at 3:22 AM PDT, Zhao Mengmeng wrote:
>> > From: Zhao Mengmeng <zhaomengmeng@kylinos=2Ecn>
>> >
>> > Pahole intersects flags across BTF_ID_FLAGS() occurrences, so omittin=
g
>> > KF_SLEEPABLE may drops the flags globally=2E sync this flags in
>> > hid_bpf_syscall_kfuncs set to enforce consistency and safety=2E
>>=20
>> Makes no sense=2E
>> These kfuncs are not sleepable=2E
>
>I'm not sure I parse correctly the reason for the dropping of the flags
>by pahole, but all of those kfuncs are actually sleepable, except for
>hid_bpf_input_report, which is *not* sleepable=2E
>
>Cheers,
>Benjamin


Hi Benjamin,
Sorry for the noise=2E I misunderstood the difference between KF_SLEEPABLE
 and other KF_XX flags=2E The initial reason to send the patch is l found =
a
 function signature change after a kfunc in two kfuncs sets, one with KF_I=
MPLICIT_ARGS,=20
while the other one without it=2E So I naively think that all kfuncs shoul=
d
 keep consistant declaration=2E Alexei is right, l will do more background=
 work
 before sending patches next time=2E

