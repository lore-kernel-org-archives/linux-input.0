Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F1A30148A
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403934; cv=none; b=jenLRKCxZ0Anr5SWyTGW74xXajtNV9MyUQ55AyAz14Ilz/bmxU88F+IKvw7CaHF4d0jtWzKtfxuEAY8lz2ODqcq95rkZdC9DWPVWnAWG3aHlrsdzRQVc8Gz2ydcGHSOrd1OayLu7OqgKGblpe8n+JBQhSdGCB4MoeKiD2Mv2jrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403934; c=relaxed/simple;
	bh=lu5tSh8Ee+jXc9uOSO8vngE0xJlDVhetA2CAqpz25og=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:Mime-Version:
	 References:In-Reply-To; b=Ov+v5wMn8EiPNGZmRjv1lw+TYJWOQ9PQDSKoKSbITrpOG6qYIWCMMqiHKDiaZxsSZ7jj2582SUEGZQx2/UsehvgguVhfeflCc/bo5RZ5+XTmjDTQUp85IoJmlJ+NzlL3bW1f84UjHyzY/7m1KmiFOEkRc5d97nblXcxMk/rA0Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=W/mBKrs+; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=SpGK8avQ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="W/mBKrs+";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="SpGK8avQ"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=W/mBKrs+FSjVi57N44vta6jyWW5/cMbbtkuZ177rNfQKq/T6iEy0axw2Mi0A7KPY5q9q0jI8MD/4a2YhmM1JTdsyFsLq9SBva3gqBhJC7BuGXB3hDPClUT5YcU/3zTDjb38URb52rvvlDzm1H2IKIwn95c7tBctbjdhiSxhR+lR3QwHDjkvofczI2ns9zNcNVnB+vklGd4WEp0l2GmHi9oRBFRxNZpJYs4qld3TSAxNEpWzF6aEsXjjwHZmZxr925G+FYj/IUeMhtjNzwnwF6M7cBRr5E69b/8XC1Ause0D1P4lFIt4CRLmIbrx9d5Ge9OgX87set8vapn0pkXvqQA==; s=purelymail1; d=rcpassos.me; v=1; bh=lu5tSh8Ee+jXc9uOSO8vngE0xJlDVhetA2CAqpz25og=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=SpGK8avQHfH+YWvRbrBk8wLSdHcVtHiad7blAaJQyF+hC/6qFT3FiMy3azWMLtawZf/F32gkljFt7k2S4nBRDEacAHH73kt5gpGec5i3TaUnMEP8mZacqxITe1923Fxqm1RZWBdChbhHuVYuacHbhFoFGdQmqYkRQpYli6M0Eu0PHhB2MVLO4MFmgTB9R2sExh98soQ/ionxT7CfmMW67KVuKKbCQAAaWmG7L3srnM47DvYb96S3S5j9N+V9xy69DgPVMF+IZ9k+DdZSA2ESWZGoUyslhqfgSnvgEZ+3LKKwGLFuyvx4l3CkJlKdiMIDx2unGpiCGD/rc3oTVQWkig==; s=purelymail1; d=purelymail.com; v=1; bh=lu5tSh8Ee+jXc9uOSO8vngE0xJlDVhetA2CAqpz25og=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1194002695;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 02 Jun 2026 12:38:48 +0000 (UTC)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 09:39:31 -0300
Message-Id: <DIYKJ99R2CS5.1F1C9UITYXE3D@rcpassos.me>
From: "Rafael Passos" <rafael@rcpassos.me>
To: <regressions@lists.linux.dev>
Cc: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-bluetooth@vger.kernel.org>, "Rafael Passos" <rafael@rcpassos.me>
Subject: Re: [REGRESSION] RIP: 0010:hidinput_setup_battery.isra.0+0x6d/0x370
 [hid]
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <ah6vRH9J9LSvnKWW@mail.iam.tj>
 <b84a408c-b12c-40e5-b44b-62aa072cb285@leemhuis.info>
In-Reply-To: <b84a408c-b12c-40e5-b44b-62aa072cb285@leemhuis.info>

I'm really happy it helped!

Cheers!
Rafael Passos,
Software Engineer
S=C3=A3o Paulo, Brasil
