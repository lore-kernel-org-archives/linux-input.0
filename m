From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: Lenovo Active Pen 2 and wacom tablet on yoga 920
Date: Mon, 11 Dec 2017 10:19:30 -0800
Message-ID: <CANRwn3SWMhrodDbgDn3WzzwEZcgvdo_vWndesD=O87JiEBWAyg@mail.gmail.com>
References: <458e9d7a-2599-915c-c15e-d08b43f4998d@scrye.com>
 <CANRwn3TwZ3xsFGBPC_OLm4tVEc5ZRpmYkiMNnFHjpPre8EXy2g@mail.gmail.com>
 <cae6e993-80af-9acd-b52f-34e493908820@scrye.com> <CANRwn3QhW8Ug5=8N3_7hhM-9MdKwY2xtuvp7P5J=2qYo3Y1MPQ@mail.gmail.com>
 <2c3db740-8afa-2c35-f4b8-fe38253ff6fc@scrye.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a114d881863372b05601493cd"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:36652 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbdLKSTc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Dec 2017 13:19:32 -0500
Received: by mail-ua0-f174.google.com with SMTP id w47so12616130uah.3
        for <linux-input@vger.kernel.org>; Mon, 11 Dec 2017 10:19:32 -0800 (PST)
In-Reply-To: <2c3db740-8afa-2c35-f4b8-fe38253ff6fc@scrye.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Fenzi <kevin@scrye.com>
Cc: Linux Input <linux-input@vger.kernel.org>

--001a114d881863372b05601493cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2017 at 2:24 PM, Kevin Fenzi <kevin@scrye.com> wrote:
> On 12/08/2017 01:24 PM, Jason Gerecke wrote:
>> Sorry about the delay in getting back to you on this issue. It looks
>
> No problem at all. Thanks for looking into it!
>
>> like there are several different reasons that we could be getting
>> EREMOTEIO from the lower levels. Would you mind running the sysinfo.sh
>> script described at [1] and filing a bug to the project with the
>> output attached?
>
> Done:
> https://github.com/linuxwacom/wacom-hid-descriptors/issues/9
>
>> This should give me an idea of what kind of hardware
>> is present in your 920. You might also try doing the following to see
>> if anything interesting gets printed to the dmesg log:
>>
>>     # echo "file drivers/i2c/*.c +p" > /sys/kernel/debug/dynamic_debug/c=
ontrol
>>     # modprobe -r wacom
>>     # modprobe wacom
>
> Seems to say:
>
> # echo "file drivers/i2c/*.c +p" > /sys/kernel/debug/dynamic_debug/contro=
l
> -bash: /sys/kernel/debug/dynamic_debug/control: Operation not permitted
>
>>
>> Some of the I2C modules (which I suspect your sensor is using) log
>> debug messages prior to returning EREMOTEIO. The above will cause
>> these debug messages to be printed to dmesg and then reload the wacom
>> module. With luck, we might gain a little more information about
>> what's triggering the error.
>
> Sadly not... but I will poke and it and see if I can figure out why it's
> not working.
>
> kevin
>

Thanks for the sysinfo output :) It looks like your system has the
sensor connected through a designware I2C controller. The only place I
see EREMOTEIO used within the designware driver is to signal that it
got a NAK at some point during the transfer. It is supposed to print
out additional details using dev_dbg, but that won't be useful until
the "Operation not permitted" error is overcome.

Some NAK conditions are transient, so its possible that our driver
just needs to retry the command. Please read the page at [1] for
instructions to compile out out-of-tree version of the wacom driver.
In place of the "Download" instructions on that page, use the
"Development" instructions. Once you're set, apply the attached patch
by running `git am /path/to/file.patch` from within the input-wacom
directory. Compile the driver and then load it in place of the system
driver by running `sudo modprobe -r wacom && sudo insmod
4.5/wacom.ko`. Check to see if there's any interesting dmesg output
and if the pen works.

[1]: http://linuxwacom.sourceforge.net/wiki/index.php/Input-wacom

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

--001a114d881863372b05601493cd
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-TEST-Always-retry-in-get-set-report.patch"
Content-Disposition: attachment;
	filename="0001-TEST-Always-retry-in-get-set-report.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jb2ivm2x1

RnJvbSAxZjg0NmM3ZDc4MDM0YjE5NDYwODBjYzlmZmI2NjcyZjVjZmU2MzhjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXNvbiBHZXJlY2tlIDxraWxsZXJ0b2Z1QGdtYWlsLmNvbT4K
RGF0ZTogTW9uLCAxMSBEZWMgMjAxNyAxMDoxNjoxMSAtMDgwMApTdWJqZWN0OiBbUEFUQ0ggaW5w
dXQtd2Fjb21dIFRFU1Q6IEFsd2F5cyByZXRyeSBpbiBnZXQvc2V0IHJlcG9ydAoKLS0tCiA0LjUv
d2Fjb21fc3lzLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvNC41L3dhY29tX3N5cy5jIGIvNC41L3dhY29tX3N5
cy5jCmluZGV4IDM5YWFhYjAuLjAzNmI1YmIgMTAwNjQ0Ci0tLSBhLzQuNS93YWNvbV9zeXMuYwor
KysgYi80LjUvd2Fjb21fc3lzLmMKQEAgLTUyLDcgKzUyLDcgQEAgc3RhdGljIGludCB3YWNvbV9n
ZXRfcmVwb3J0KHN0cnVjdCBoaWRfZGV2aWNlICpoZGV2LCB1OCB0eXBlLCB1OCAqYnVmLAogCWRv
IHsKIAkJcmV0dmFsID0gaGlkX2h3X3Jhd19yZXF1ZXN0KGhkZXYsIGJ1ZlswXSwgYnVmLCBzaXpl
LCB0eXBlLAogCQkJCUhJRF9SRVFfR0VUX1JFUE9SVCk7Ci0JfSB3aGlsZSAoKHJldHZhbCA9PSAt
RVRJTUVET1VUIHx8IHJldHZhbCA9PSAtRUFHQUlOKSAmJiAtLXJldHJpZXMpOworCX0gd2hpbGUg
KC0tcmV0cmllcyk7CiAKIAlpZiAocmV0dmFsIDwgMCkKIAkJaGlkX2VycihoZGV2LCAid2Fjb21f
Z2V0X3JlcG9ydDogcmFuIG91dCBvZiByZXRyaWVzICIKQEAgLTY5LDcgKzY5LDcgQEAgc3RhdGlj
IGludCB3YWNvbV9zZXRfcmVwb3J0KHN0cnVjdCBoaWRfZGV2aWNlICpoZGV2LCB1OCB0eXBlLCB1
OCAqYnVmLAogCWRvIHsKIAkJcmV0dmFsID0gaGlkX2h3X3Jhd19yZXF1ZXN0KGhkZXYsIGJ1Zlsw
XSwgYnVmLCBzaXplLCB0eXBlLAogCQkJCUhJRF9SRVFfU0VUX1JFUE9SVCk7Ci0JfSB3aGlsZSAo
KHJldHZhbCA9PSAtRVRJTUVET1VUIHx8IHJldHZhbCA9PSAtRUFHQUlOKSAmJiAtLXJldHJpZXMp
OworCX0gd2hpbGUgKC0tcmV0cmllcyk7CiAKIAlpZiAocmV0dmFsIDwgMCkKIAkJaGlkX2Vyciho
ZGV2LCAid2Fjb21fc2V0X3JlcG9ydDogcmFuIG91dCBvZiByZXRyaWVzICIKLS0gCjIuMTUuMQoK
--001a114d881863372b05601493cd--
