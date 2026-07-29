Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C0469832
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344158; cv=none; b=V7Cu5tNH/+y/6zymiXTl7dvul801Q+8QBeiye8s18iGHIUhXk6o7Yo5fnjgb1umnovU+vDLgfIxjE+zT8xyMMz/X7FWuHRW4SUI38+N2dwSE3f5W7I8W3NfZLvIQLxUDB7TIvNLlhzJPnvjd16HNXtZdUyTcQj326JdhJqxDNN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344158; c=relaxed/simple;
	bh=YVcfjMkeKUfhXCSTbMGDGj3/TSqHhJ1soleo9dQYDhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otuyCbgN+L7159C75IoGZtJutAZPQ+zLZzNHBIPpgugney9H1g6q1HITnbPiNJN9l47wdlxbKJZ1iKCFisxzjnCc4uTTlUS5nokhPxXBTzijyFTrsL3pBaCuPa9D7qOZdGo4iLHRuo74jWDBXgVYXSpa3XkoaIFOEw9+76OtoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=HezeFRCo; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=HnCoMMh8; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="HezeFRCo";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="HnCoMMh8"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=HezeFRCoVCN5LRCKoDn55JX4Wl4/rBFyGyhhIcHOak1VQI16sT/qqKfx45FT0mmTr9Tt4MhW3OzPQYsdtZ3906wfIiuhGAUEmQS2FEuKPkkwVgseKOR7d+mIiyNQvQYM6F0+ESmPNTkP1fpiMdNuRY+523ZyfgQovnL5qiq5PKcpJIC3WgUR9vhATn5COybU+d282LCgZSnI+CqxoSvwSxKxU2Cr340CE5sZk8uXQapcb71Q97+xqRcmIleu/e8UxrzLZPZQ3D0vfPwYOl0Sts+4Ho6IHeePj5+XEIBW0sEwx20Pv43KZJErQ992nSj22nY7mStm7fQh4vQeWJGldA==; s=purelymail3; d=rcpassos.me; v=1; bh=YVcfjMkeKUfhXCSTbMGDGj3/TSqHhJ1soleo9dQYDhI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=HnCoMMh8EceIb+1ouILybc5XxmszPbyRyhY4D7G33gPpL43FLxda9kekj4hecH16uzEC+uBxWYRzgq/XFvlk1m2Q8c2s/aa4tDugHKVgpUyNkJ/rUKbl5NYWIzvCbiffW9EqiC13sgNFUBiawAXIQNrEdef24umnbJ4MtSrTcfsWTCMlCe+hyqzDY6yb4LB8xohqVw2FQ8C3C0ZvIYQ8BOs57UsIrmU/drGGMJGUV45a7GKuNlsrl+DHtjyA/66V2cJjgbB3Me2uKubQdp7f0cBGKhEfPiS4h2cQyGY55fIfEv1qO/T8QYxo1nQhni2flN0NX1opzgRkmmpzlz1sgQ==; s=purelymail3; d=purelymail.com; v=1; bh=YVcfjMkeKUfhXCSTbMGDGj3/TSqHhJ1soleo9dQYDhI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2129648507;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 29 Jul 2026 16:55:44 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: David Rheinsberg <david@readahead.eu>,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v3 4/4] HID: wiimote: fix uaf when hid events are handled during destroy
Date: Wed, 29 Jul 2026 13:49:15 -0300
Message-ID: <20260729164928.1138468-5-rafael@rcpassos.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729164928.1138468-1-rafael@rcpassos.me>
References: <20260729164928.1138468-1-rafael@rcpassos.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

In wiimote_destroy, in the time between setting WIIPROTO_FLAG_EXITING
and hid_hw_stop, new events could be handled.
The new behaviour mirrors hid-playstation's output_worker_initialized
flag-gate (source of inspiration).

This issue was reported as a pre-existign race condition by sashiko.
I confirmed it is possible, but very unlikely. It could only happen if
shutdown is initiated by Linux, and the controller is being used.

Signed-off-by: Rafael Passos <rafael@rcpassos.me>
---
 drivers/hid/hid-wiimote-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.=
c
index 31ee86affc553..067db8b8a56d1 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -92,6 +92,9 @@ static void wiimote_queue(struct wiimote_data *wdata, con=
st __u8 *buffer,
 =09 */
=20
 =09spin_lock_irqsave(&wdata->queue.lock, flags);
+=09/* Do not schedule work if controller is exiting */
+=09if ((wdata->state.flags & WIIPROTO_FLAG_EXITING))
+=09=09goto out_unlock;
=20
 =09memcpy(wdata->queue.outq[wdata->queue.head].data, buffer, count);
 =09wdata->queue.outq[wdata->queue.head].size =3D count;
--=20
2.53.0

