Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8E3BB66C
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784150834; cv=none; b=booWuv8TDbbIA2fwsVoeZNckyPEsf58nXtIZw/e3MnENqOYW4HuHNjsKWEeC9QWRfYjSJxYQlB8Ly3NvCPjgME6Io4lqmt04iXATbsLbNPOqMOaHkkaiUsby4yy2lj0rF3WWJ+5Pvw677ZYHvFHOcayjRA8fePTGYCYrzTwbFyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784150834; c=relaxed/simple;
	bh=XVQHzVmBYkNLwC1WVwryVN6+xYK/MZnpkO4WrvxTWz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q9HSNuc43Ep5ECXP5mqx45dpqxHvlCOWf1VmCFkvsDywftfxfV07TR2qzq5/ki7zd7CGWSmT12fL1dPWEz9N/dMN1GbWFJ8Y4g5rjmrQD8y3I9vqSKuN5uxdOOxcuBkyQmswfrqhHoocytVvTVbxW9MPJAwH9jdmttG+1Z7c6rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=VGUfMmgE; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=nEMZALq2; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="VGUfMmgE";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="nEMZALq2"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=VGUfMmgE/8kBnI221uoMzKkhaQIH5y+Gc0tnAAmgGph/sbxa2jiL1Al0N1NIRNsscZbRejPNGKgu6dff8EfOY/7vYFdJKEMe5o/Hllt9e9r7eOn/7KSByUrmNOVvDcdFioVWZpX5zjEM7vf1/gJpJO0Mm6Ukf2am1YkidLZR5YXs6K1IUIN2a1CmlbvnyKdNztKS3p1ae0TRaOKfB/G3c9UlknTJEp5gB0VeGSBUqZ7yw+LwwyvUJMaPu3h46yYnG8iCUNQYQcXJxw46OMoXvRi8OaRIDHtILxKir1+3/032TB+QBpt2w3T6YSMDP7BOboLfV0lK9vi1/a78kBMCkA==; s=purelymail2; d=rcpassos.me; v=1; bh=XVQHzVmBYkNLwC1WVwryVN6+xYK/MZnpkO4WrvxTWz4=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=nEMZALq28FjM/NPWwu1spFPXjFY56GnOcZl7N9NS+sqQH3fDW5bM2JzZULFYXqn5unyyfg7RrDEyhogNvMPFiCiUDXQocxoq+ZDrtrW7j2dE/FONSAhJyFBevfyesJeg7ayPg9zpD1pnebZtypSMf5MMqMZFwUzepmRFGK8A+CLVR/1PpoGm2gRcQAwSJNaieDa3WGs6Z62BQX/GfoKJVPn8fg7JYAmqL6pSwQuzZb/78BheesAFL9SD7wSKGcuCi4wt8LP15T/1Fuz/dwZc8sGb7kpcm9J5h93DuCZy92aNUullueSSaZ0FbxBpIyAWwaem5obdxlYwmQY3TiJ27A==; s=purelymail2; d=purelymail.com; v=1; bh=XVQHzVmBYkNLwC1WVwryVN6+xYK/MZnpkO4WrvxTWz4=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 471802508;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 15 Jul 2026 21:27:03 +0000 (UTC)
From: Rafael Passos <rafael@rcpassos.me>
To: david@readahead.eu,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: jkoolstra@xs4all.nl,
	Rafael Passos <rafael@rcpassos.me>,
	linux-input@vger.kernel.org
Subject: [PATCH v2 4/4] HID: wiimote: fix uaf when hid events are handled during destroy
Date: Wed, 15 Jul 2026 18:24:56 -0300
Message-ID: <20260715212501.3920033-5-rafael@rcpassos.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715212501.3920033-1-rafael@rcpassos.me>
References: <20260715212501.3920033-1-rafael@rcpassos.me>
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
index b549a7d58d51..c9638ec352e4 100644
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

