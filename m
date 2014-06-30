From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH v2 0/14] input: cyapa: re-architecture driver to support
 multi-trackpads in one driver
Date: Mon, 30 Jun 2014 06:54:57 +0000
Message-ID: <77BC725C9062764F874D79F51E1F1A8F4C902D71@S04-MBX01-01.s04.local>
References: <CAEn7tidaRxbLwQti8joDgq48K2YCAVE3uG-q6ZR=jEWAgm2tPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay-s04-hub002.domainlocalhost.com ([74.115.207.101]:34946
	"EHLO relay-S04-HUB002.domainlocalhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752131AbaF3Gy7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2014 02:54:59 -0400
In-Reply-To: <CAEn7tidaRxbLwQti8joDgq48K2YCAVE3uG-q6ZR=jEWAgm2tPg@mail.gmail.com>
Content-Language: zh-CN
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Patrik Fimml <patrikf@google.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Benson Leung <bleung@google.com>, Lily Rui <lily@cypress.com>, Daniel Kurtz <djkurtz@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

SGkgQWxsLA0KDQpTb3JyeSBmb3IgdGhlIGRpc3R1cmIgYWdhaW4uDQpUaGUgMTQgY2F5cGEgVjIg
cGF0Y2hlcyBJIHJlLXNlbnQgdGhyb3VnaCAxNDo0MSB0byAxNDo0NSBhdCAyMDE0LzYvMzAgc3Rp
bGwgaGF2ZSBzb21lIG9mIHRoZW0gY29ycnVwdGVkIGJ5IHRoZSBtYWlsIHNlcnZlci4NClBsZWFz
ZSBpZ25vcmUgdGhlbS4gSSB3aWxsIHRyeSB0byBmaXggdGhlbS4NCg0KVGhhbmtzLA0KRHVkbGV5
DQpUaGlzIG1lc3NhZ2UgYW5kIGFueSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBDeXByZXNzIChv
ciBpdHMgc3Vic2lkaWFyaWVzKSBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIGl0IGhhcyBi
ZWVuIHJlY2VpdmVkIGluIGVycm9yLCBwbGVhc2UgYWR2aXNlIHRoZSBzZW5kZXIgYW5kIGltbWVk
aWF0ZWx5IGRlbGV0ZSB0aGlzIG1lc3NhZ2UuDQo=
