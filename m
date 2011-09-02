From: Amit Nagal <helloin.amit@gmail.com>
Subject: Re: [PATCH] hidraw : free list for all error in hidraw_open
Date: Fri, 2 Sep 2011 12:57:58 +0530
Message-ID: <CA+F9FsA=u6EtGkWO8PVfJ4voSx+=wvoFdZ_61WO6x=8WMFM0Rg@mail.gmail.com>
References: <CA+F9FsBqeW9PEL9F5h4Rx+-2QY=PcFXW0MVyZPJJOjUo5zGeig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e64082a2f0d4ac04abf04cb2
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f42.google.com ([209.85.216.42]:54634 "EHLO
	mail-qw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab1IBH17 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Sep 2011 03:27:59 -0400
In-Reply-To: <CA+F9FsBqeW9PEL9F5h4Rx+-2QY=PcFXW0MVyZPJJOjUo5zGeig@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Alan Ott <alan@signal11.us>

--0016e64082a2f0d4ac04abf04cb2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 2, 2011 at 10:59 AM, Amit Nagal <helloin.amit@gmail.com> wrote:
> Hi ,
>
> In function hidraw_open (linux-3.0.3/drivers/hid/hidraw.c ) , =A0struct
> hidraw_list *list should be freed for all error conditions .

Due to tab to space conversion by gmail , i have enclosed patch as
attachment currently .

Regards
Amit

--0016e64082a2f0d4ac04abf04cb2
Content-Type: application/octet-stream;
	name="[Patch]  hidraw_open free list for errors"
Content-Disposition: attachment;
	filename="[Patch]  hidraw_open free list for errors"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gs2ucm2r0

U2lnbmVkLW9mZi1ieTogQW1pdCBOYWdhbCA8aGVsbG9pbi5hbWl0QGdtYWlsLmNvbT4KLS0tCgpk
aWZmIC11cCBhL2RyaXZlcnMvaGlkL2hpZHJhdy5jIGIvZHJpdmVycy9oaWQvaGlkcmF3LmMKLS0t
IGEvZHJpdmVycy9oaWQvaGlkcmF3LmMJMjAxMS0wOC0xNyAxMzo1NzoxNi4wMDAwMDAwMDAgLTA0
MDAKKysrIGIvZHJpdmVycy9oaWQvaGlkcmF3LmMJMjAxMS0wOS0wMiAwNzowNjo1Mi4wMDAwMDAw
MDAgLTA0MDAKQEAgLTI1OSw3ICsyNTksNiBAQCBzdGF0aWMgaW50IGhpZHJhd19vcGVuKHN0cnVj
dCBpbm9kZSAqaW5vCiAKIAltdXRleF9sb2NrKCZtaW5vcnNfbG9jayk7CiAJaWYgKCFoaWRyYXdf
dGFibGVbbWlub3JdKSB7Ci0JCWtmcmVlKGxpc3QpOwogCQllcnIgPSAtRU5PREVWOwogCQlnb3Rv
IG91dF91bmxvY2s7CiAJfQpAQCAtMjg1LDYgKzI4NCw4IEBAIHN0YXRpYyBpbnQgaGlkcmF3X29w
ZW4oc3RydWN0IGlub2RlICppbm8KIG91dF91bmxvY2s6CiAJbXV0ZXhfdW5sb2NrKCZtaW5vcnNf
bG9jayk7CiBvdXQ6CisJaWYgKGVyciA8IDApCisJCWtmcmVlKGxpc3QpOwogCXJldHVybiBlcnI7
CiAKIH0KCi0tCg==
--0016e64082a2f0d4ac04abf04cb2--
