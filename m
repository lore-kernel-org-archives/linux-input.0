Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794095069;
	b=rC2JLlrDXmtcVxlf+dM5+4jjoykW5zzZPV6XseQACKaJoiPK1hrRLn69ATSDV53AtyBu
	 fhIAH+wyZ42HhtLcKxV8o1D8E8uVgguf1UFcW7k9JnjhW5A5gV/N56xOC7gMI59bk4NLo
	 4bfw2mkT7nRjOPVgZpARVQ1BgFBWB3myAlSq0KPrrAh8dT+fLpfVbam3H0mFzdnL3jLLf
	 /THU5+yoXCeKDQFCyXSiVJn4z2vEB6VMorZxiexSJIcT/lQFyAUtntUuYsa1LlSMMabeH
	 AAzQr+vYSwITYGn84RuXYAmQ8hAtcgIokUcz2jUq1TUE+1Qc+zXZ/5/yaCO2+PHvvng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794095069;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=XRo5GmA0GQ35Bp1sx4M4gmJrDlqDnPyxXOg2fAZaFSc=;
	b=faZLgSrJtzAatFC8YoJLb7YQc607DoOgby0pidBD0zxFre0+XvPzMtCQdLMAvFnT5le+
	 aH/Gi5MkiF3sCrMlEKpo2FzyAzQl8OWK+ZIB4pIkVA6+Wzm60ue8XBenuD8iBea841W70
	 p4CD7riIDVEy9XiWWWe0JuslVHXGy9/mKLgu7q3wSK/MYhNB/o/SgzINU5ZfhslgY1OF9
	 Mth4D/cq4wMbCKqFIQpNhaeotjAIshltf92GQUVZ/zI/g3j9jRV+HefIE28a5jIsQg/7o
	 NmKvmhMFYcYwTqbfgBacQ8g+J7NJ1VCeqUSn0b4V8Bc2OCmnnTaZe9kU+aqybqBkHjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kNbaBipV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FF9606A326;
	Sat,  7 Nov 2026 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kNbaBipV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BD41F0089F;
	Sat,  7 Nov 2026 23:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794095069;
	bh=XRo5GmA0GQ35Bp1sx4M4gmJrDlqDnPyxXOg2fAZaFSc=;
	h=From:To:Cc:Subject:Date;
	b=kNbaBipVwcU4/q2d7jG93ZnOfvEN78IfY0u4R6kE27LOLulS3VnbheDX93aX0Xm3B
	 cdcfHfptPKd8Szl8mRsLHxaAmKMJd0eOY3OIqjcbZlKjehY1SdLKlGwxaI1Nxh6UcN
	 pUakG8zfsofmF3vUb42i/CagLueoLEg9rbg6DQJouJVDQ00I/4rERRk1PRizXvC+cY
	 dm+EzIGEq9Ipv/AmPnP6E32bzYtdjyqfgrwUZSKMYiYDzLKJDiiTkA0JwmL8APLjMh
	 XU3y7DWw78aiFAhBTtM8fyyZf1uYjTUJWCmJ1Eri6A9x4hAgKv385NIhrMwIUMDaqH
	 eq+9gIMlC/Xfw==
From: Thorsten Blum <blum@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: amijoy - remove amijoy_phys
Date: Sun,  8 Nov 2026 00:43:47 +0100
Message-ID: <20261107234349.382944-3-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=blum@kernel.org; h=from:subject; bh=2EEp21DeOVypGkdIacSVjdQZ+ZgwGS9NRiPOQjHhNoc=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnvt299FTxfkemFjrSf3mUTbcV3OVIbWf/Oydp6z7hO9 dsFBatfHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRBfMZ/mcLV/ee/dj8pk1U YmbJq4AYf4vIa0JlE1MXHvtza8O7WQkMf2W+TNhe2ZkQVv6I+7tLwmor6WQvyZAKn823arbM1PL r5AMA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

amijoy_phys has only two entries and is only used by amijoy_init().
Select the physical path directly and remove the array.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Changes in v2:
- Remove amijoy_phys as suggested by Dmitry
- v1: https://lore.kernel.org/r/20261107174739.369375-2-blum@kernel.org/

 drivers/input/joystick/amijoy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/joystick/amijoy.c b/drivers/input/joystick/amijoy.c
index 3752dc2a2086..cfe407b56c41 100644
--- a/drivers/input/joystick/amijoy.c
+++ b/drivers/input/joystick/amijoy.c
@@ -30,7 +30,6 @@ MODULE_PARM_DESC(map, "Map of attached joysticks in form of <a>,<b> (default is
 static int amijoy_used;
 static DEFINE_MUTEX(amijoy_mutex);
 static struct input_dev *amijoy_dev[2];
-static char *amijoy_phys[2] = { "amijoy/input0", "amijoy/input1" };
 
 static irqreturn_t amijoy_interrupt(int irq, void *dummy)
 {
@@ -108,7 +107,7 @@ static int __init amijoy_init(void)
 		}
 
 		amijoy_dev[i]->name = "Amiga joystick";
-		amijoy_dev[i]->phys = amijoy_phys[i];
+		amijoy_dev[i]->phys = i ? "amijoy/input1" : "amijoy/input0";
 		amijoy_dev[i]->id.bustype = BUS_AMIGA;
 		amijoy_dev[i]->id.vendor = 0x0001;
 		amijoy_dev[i]->id.product = 0x0003;
