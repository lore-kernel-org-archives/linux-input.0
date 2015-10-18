From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2] hp_sdc_rtc: fixed y2038 problem in proc_show
Date: Sun, 18 Oct 2015 16:35:08 -0700
Message-ID: <20151018233508.GC12041@dtor-ws>
References: <3021182.6jgkaVHA9u@wuerfel>
 <1442411138-773-1-git-send-email-pingbo.wen@linaro.org>
 <2616886.83FcmajDm5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
Content-Disposition: inline
In-Reply-To: <2616886.83FcmajDm5@wuerfel>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, WEN Pingbo <pingbo.wen@linaro.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

T24gV2VkLCBTZXAgMTYsIDIwMTUgYXQgMDM6NTU6MzdQTSArMDIwMCwgQXJuZCBCZXJnbWFubiB3
cm90ZToKPiBPbiBXZWRuZXNkYXkgMTYgU2VwdGVtYmVyIDIwMTUgMjE6NDU6MzggV0VOIFBpbmdi
byB3cm90ZToKPiA+IGhwX3NkY19ydGNfcHJvY19zaG93KCkgdXNlIHRpbWV2YWwgdG8gc3RvcmUg
dGhlIHRpbWUsIHdoaWNoIHdpbGwKPiA+IG92ZXJmbG93ZWQgaW4gMjAzOC4KPiA+IAo+ID4gVGhp
cyBwYXRjaCBmaXhlcyB0aGlzIHByb2JsZW0gYnkgcmVwbGFjaW5nIHRpbWV2YWwgd2l0aCB0aW1l
c3BlYzY0Lgo+ID4gaHBfc2RjX3J0Y19wcm9jX3Nob3coKSBvbmx5IG91dHB1dCBzdHJpbmcsIHNv
IHRoYXQgdXNlcnNwYWNlIHdpbGwgd29yawo+ID4gbm9ybWFsbHkgaWYgd2UgYXBwbHkgdGhpcyBw
YXRjaC4KPiA+IAo+ID4gTm90IGFsbCB0aW1lciBpbiBpODA0MiBoYXZlIHkyMDM4IHJpc2soaGFu
ZHNoYWtlLCBtYXRjaCB0aW1lciwgZXRjKSwKPiA+IFJlcGxhY2VtZW50cyBpbiB0aG9zZSB0aW1l
ciBhcmUganVzdCBmb3IgY29uc2lzdGVuY3kuCj4gPiAKPiA+IFZlcnNpb24gMiBVcGRhdGVzOgo+
ID4gLSBjb21waWxlZCBpbiBtNjhrIGdjYyBjcm9zcyBjb21waWxlcig0LjYuMyksIG5vIGV4dHJh
IHdhcm5pbmdzCj4gPiAtIHBsYWNlZCBzNjQgdHlwZSBjYXN0IGluIHR2LnR2X3NlYywgbWFraW5n
IHN1cmUgaXQgd29yayBwcm9wZXJseSBpbgo+ID4gYm90aCAzMmJpdCBhbmQgNjRiaXQgcGxhdGZv
cm0uCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IFdFTiBQaW5nYm8gPHBpbmdiby53ZW5AbGluYXJv
Lm9yZz4KPiA+IENjOiBZMjAzOCA8eTIwMzhAbGlzdHMubGluYXJvLm9yZz4KPiA+IAo+IAo+IExv
b2tzIHZlcnkgZ29vZCwKPiAKPiBSZXZpZXdlZC1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5k
Yi5kZT4KCkFwcGxpZWQsIHRoYW5rIHlvdS4KCi0tIApEbWl0cnkKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWTIwMzggbWFpbGluZyBsaXN0ClkyMDM4QGxp
c3RzLmxpbmFyby5vcmcKaHR0cHM6Ly9saXN0cy5saW5hcm8ub3JnL21haWxtYW4vbGlzdGluZm8v
eTIwMzgK
