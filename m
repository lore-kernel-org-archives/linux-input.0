From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Force Feedback: Thrustmaster FGT Wheel quick-and-dirty in hid-lgff.c or hid-tmff.c
Date: Mon, 16 Jul 2007 12:05:47 -0400
Message-ID: <d120d5000707160905l214a6ec3yaefc73be5644e1b1@mail.gmail.com>
References: <469B7721.9070705@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_59853_25768741.1184601947188"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <469B7721.9070705@free.fr>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Gerald Folcher <geraldf2@free.fr>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

------=_Part_59853_25768741.1184601947188
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gerard,

On 7/16/07, Gerald Folcher <geraldf2@free.fr> wrote:
>
> I guess that a proper patch for the Thrustmaster wheel(s) would probably
> have better his place in hid-tmff.c (In fact I first gone that route but
> I had to change more code introducing more ugliness... the diff output
> from the hid-lgff.c version was much better for my "presentation" purpose).
>

I wonder if the attached is all that is needed for your wheel to work...

-- 
Dmitry

------=_Part_59853_25768741.1184601947188
Content-Type: application/octet-stream; name="hid-add-thrustmaster-fgt-wheel.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="hid-add-thrustmaster-fgt-wheel.patch"
X-Attachment-Id: f_f475epi2

SW5wdXQ6IEhJRCAtIGFkZCBzdXBwb3J0IGZvciBUaHJ1c3RtYXN0ZXIgRkdUIFJ1bWJsZSBGb3Jj
ZSB3aGVlbAoKQWRkIFRocnVzdG1hc3RlciBGR1QgUnVtYmxlIGZvcmNlIHN0ZWVyaW5nIHdoZWVs
IHRvIHRoZSBsaXN0IG9mCmRldmljZXMgZHVwcG9ydGVkIGJ5IHRocnVzdG1hc3RlciBmb3JjZS1m
ZWVkYmFjayBtb2R1bGUuCgpTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgVG9yb2tob3YgPGR0b3JAbWFp
bC5ydT4KLS0tCiBkcml2ZXJzL2hpZC91c2JoaWQvaGlkLWZmLmMgfCAgICAxICsKIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQoKSW5kZXg6IGxpbnV4L2RyaXZlcnMvaGlkL3VzYmhpZC9o
aWQtZmYuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC5vcmlnL2RyaXZlcnMvaGlkL3VzYmhpZC9oaWQt
ZmYuYworKysgbGludXgvZHJpdmVycy9oaWQvdXNiaGlkL2hpZC1mZi5jCkBAIC02Nyw2ICs2Nyw3
IEBAIHN0YXRpYyBzdHJ1Y3QgaGlkX2ZmX2luaXRpYWxpemVyIGluaXRzW10KICNpZmRlZiBDT05G
SUdfVEhSVVNUTUFTVEVSX0ZGCiAJeyAweDQ0ZiwgMHhiMzAwLCBoaWRfdG1mZl9pbml0IH0sCiAJ
eyAweDQ0ZiwgMHhiMzA0LCBoaWRfdG1mZl9pbml0IH0sCisJeyAweDQ0ZiwgMHhiNjU0LCBoaWRf
dG1mZl9pbml0IH0sCiAjZW5kaWYKICNpZmRlZiBDT05GSUdfWkVST1BMVVNfRkYKIAl7IDB4YzEy
LCAweDAwMDUsIGhpZF96cGZmX2luaXQgfSwK
------=_Part_59853_25768741.1184601947188--
