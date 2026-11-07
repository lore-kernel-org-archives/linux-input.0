Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067376;
	b=E3hfyBN7L9gv7jz1/HlB9NSjqyIf+/L8hHtBxEUHmUcE1P5mpEJQLz1xksXxLhlGxyVH
	 yTpdF9F0qDpvJRLPXvh1yZY3KmCwPUjkT07TaIMoYPw26DaaBX4yJoQO7RW8IpUwROAMs
	 ymn7OiSfQ46bmMRMDlM4xXbIP6V9EUU3Gx9NcFSoHeBa84a1RiNEW2bqhrZ1efKcAIGVj
	 va2NZ5ZDBsLbrAMlVkcGZ/rBFt7QdNvqZuJQVbK8PSRzyqtWhO1xK9UM24S2iOTfSmWP9
	 /pd32UDnIHuqbZ8O3JJSP3KFgxlYdGr7H5DxWfjnA90sAR0g353ANZdJFmaXkoWZyLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067376;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=1+WgV12xOWLepB+h+NqExv8xc49Q4Y0LZlKj22kQkl0=;
	b=rfQlmYGyqutFSnbLl0fPkwpGVutMO4WDMGMuzj56nt/DozPFWclKKFJ1Fy8ZyZuYQtgc
	 Wj3JvCQLZpePYdysA+gK8T9jPpdAk1gTYQXld/8SXH47omQKU+gZwLRJ6qlc3ltuLNeA9
	 EJ6M/ewzQjJGNH6pdab3zZNJTFwzoKe4f0blWgZbNah2LKEXAcHzrwljheOgPPATYAhZp
	 GgoIam5h5RlZOfWlpiZ/sNrOfHCd3LObtkwX+AWGtOJq0tEUN3XH9/10JHK4jxvx9BaIl
	 jg2/p4fMsfizsUM/3ia3wGFtetlTWIxhwNNHESpIaUpAvsk7KCW7/8rIZwppE23Dkug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqXOtbUy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B187606A326;
	Sat,  7 Nov 2026 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqXOtbUy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5601F0089F;
	Sat,  7 Nov 2026 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794067376;
	bh=1+WgV12xOWLepB+h+NqExv8xc49Q4Y0LZlKj22kQkl0=;
	h=From:To:Cc:Subject:Date;
	b=CqXOtbUy5cWeGjjpBjT6WN7VRjQkwOmnzP2vbv5etFX+eqkjZSYmwzmMLOtWYdKOj
	 xgKjYeY6V7xKfJ2OoJ5rzpCc+Y13Y+clWIa7yN8sRlRXIQMr7+Z1yrWeFbZ+ck1WV6
	 2YlfjGPxTdICqdKU74PJrqG4C//QHkcrriZlnmI0FBfRqD5OAlu0tv+oUjcgAbQ0yl
	 z+aH7FCeKS0nwbnrwFDDwr8M+pyXS/Pg/I5RoOek4wcfpenokoV69oiLk3xvGnNEuc
	 Q5x3LW57BVJgDW/HE1XFq/z2Ra8w7lzI4COVdI7JSxXxs3uNkP30ux06tLSdDydiq3
	 s2JZUzgwoQFWw==
From: Thorsten Blum <blum@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thorsten Blum <blum@kernel.org>,
	Dmitry Torokhov <dtor@insightbb.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: amijoy - fix memory region leak on registration failure
Date: Sat,  7 Nov 2026 17:01:57 +0100
Message-ID: <20261107160159.367919-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=832; i=blum@kernel.org; h=from:subject; bh=DeZR4zzouKciSMIXZqJOBT2CBDtS60HduEg68fkVA6c=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnvvctdt5RXRc5cq3JM+G2F+ELZjBVxe7cE5fXFl747d appRf7DjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjIymxGhj0Cxw0sk79dEl40 yzmmsdrVc82MqJ3TUno8Ev6sZTjGW8vIMHXz69VlMRECPpm/D/p1f668WiIp9zH9V4R2VYN1tN9 7bgA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

If input_register_device() fails in amijoy_init(), release the memory
region for port i before cleaning up the previously registered ports.

Fixes: 127278ce2254 ("Input: joysticks - handle errors when registering input devices")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/input/joystick/amijoy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/amijoy.c b/drivers/input/joystick/amijoy.c
index cdb2b8f15348..3c2357ba7dc3 100644
--- a/drivers/input/joystick/amijoy.c
+++ b/drivers/input/joystick/amijoy.c
@@ -132,6 +132,7 @@ static int __init amijoy_init(void)
 		err = input_register_device(amijoy_dev[i]);
 		if (err) {
 			input_free_device(amijoy_dev[i]);
+			release_mem_region(CUSTOM_PHYSADDR + 10 + i * 2, 2);
 			goto fail;
 		}
 	}
