From: Anirudh Bagde <abagde1@gmail.com>
Subject: Re: USB vulnerabilities
Date: Tue, 2 Aug 2016 00:37:45 -0400
Message-ID: <CALoFJwasLMAuhHgZF=A_PsRqhfo_VaEzKrFef7HCh5p0Bhpp0g@mail.gmail.com>
References: <4bb833c7-1e7b-fc19-7ad5-b4e881897d9a@cisco.com>
 <20160728174848.GA16852@dtor-ws> <c82cf97a-444b-07b6-bc35-6350aa3797c9@cisco.com>
 <2fd29934-03ac-b67c-a644-07aebbfe8aff@cisco.com> <20160731011443.GA22515@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1140bcda7317f805390f4883
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35521 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbcHBEi4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Aug 2016 00:38:56 -0400
Received: by mail-oi0-f47.google.com with SMTP id 4so10931845oih.2
        for <linux-input@vger.kernel.org>; Mon, 01 Aug 2016 21:38:07 -0700 (PDT)
In-Reply-To: <20160731011443.GA22515@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rosie Hall <roswest@cisco.com>, linux-input@vger.kernel.org, Christopher Kopek <ckopek@cisco.com>

--001a1140bcda7317f805390f4883
Content-Type: text/plain; charset=UTF-8

Hi Dmitry,

Thanks for the input. I have added my sign off to the iforce patch.
I'm sending it as an attachment since I don't have my email client
properly setup yet for inline patches. Let me know if there is
anything else that needs to be done.

For the touchscreen patch, I'd forgotten about NEXIO_BUFSIZE, using
that is a good alternative to changing all the reader functions.
However there is still the chance that the packet byte array is
smaller than NEXIO_BUFSIZE so there can still be a buffer overflow,
though much less significant than before, and still relatively
harmless. I will update my patch to use NEXIO_BUFSIZE if you think
that is preferrable. AS for the other two adjustments, I'm not
actually sure what purpose they serve, so I thought I should leave
them alone, but I'll try to make it more concise. I will send the
updated patch soon once I get everything setup to test the patch on my
computer.

Thanks,
Anirudh Bagde
 --
Anirudh Bagde


On Sat, Jul 30, 2016 at 9:14 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Rosie, Anirudh,
>
> On Fri, Jul 29, 2016 at 08:48:01PM -0400, Rosie Hall wrote:
>> Dmitry,
>>
>> Attached are the patches Anirudh created.  Also, I have added him to the
>> thread if you have any questions or comments for him.
>>
>> Rosie
>
> ...
>
>
>> --- a/drivers/input/joystick/iforce/iforce-usb.c      2016-07-29 15:02:47.602630504 -0400
>> +++ b/drivers/input/joystick/iforce/iforce-usb.c      2016-07-29 15:02:32.946812336 -0400
>> @@ -135,12 +135,23 @@
>>  {
>>       struct usb_device *dev = interface_to_usbdev(intf);
>>       struct usb_host_interface *interface;
>> -     struct usb_endpoint_descriptor *epirq, *epout;
>> +     struct usb_endpoint_descriptor *epirq = NULL, *epout = NULL;
>>       struct iforce *iforce;
>> -     int err = -ENOMEM;
>> +     int i, err = -ENOMEM;
>>
>>       interface = intf->cur_altsetting;
>>
>> +     for (i = 0; i < interface->desc.bNumEndpoints; i++) {
>> +             if (!epirq &&
>> +                 usb_endpoint_dir_in(&interface->endpoint[i].desc))
>> +                     epirq = &interface->endpoint[i].desc;
>> +             if (!epout &&
>> +                 usb_endpoint_dir_out(&interface->endpoint[i].desc))
>> +                     epout = &interface->endpoint[i].desc;
>> +     }
>> +     if (!epirq || !epout)
>> +             return -ENODEV;
>> +
>>       epirq = &interface->endpoint[0].desc;
>>       epout = &interface->endpoint[1].desc;
>>
>
>
> The iforce patch looks good, but I need "Signed-off-by" from Anirudh for
> me to apply it. Please see Documentation/SubmittingPatches.
>
>
>>
>> -static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char *pkt)
>> +static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char *pkt,
>> +                        unsigned int len)
>
> I do not think we need to pass the length to the readers: we know what
> protocol we are dealing with and we can simply use NEXIO_BUFSIZE.
>
>>  {
>>       struct nexio_touch_packet *packet = (void *) pkt;
>>       struct nexio_priv *priv = usbtouch->priv;
>> @@ -977,6 +996,11 @@
>>       if ((pkt[0] & 0xe0) != 0xe0)
>>               return 0;
>>
>> +     if (data_len > len)
>> +             data_len = len;
>> +     if (x_len + y_len > data_len)
>> +             return 0;
>
> We have more adjustments to x_len and data_len below, so maybe we
> should move these new checks there as well?
>
>> +
>>       if (data_len > 0xff)
>>               data_len -= 0x100;
>>       if (x_len > 0xff)
>
> Thanks.
>
> --
> Dmitry

--001a1140bcda7317f805390f4883
Content-Type: application/octet-stream; name="iforce-usb.patch"
Content-Disposition: attachment; filename="iforce-usb.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ircz3b0g0

UGF0Y2ggdG8gYWRkIGVycm9yIGNoZWNraW5nIHRvIHRoZSBpZm9yY2Ugam95c3RpY2sgZHJpdmVy
IHdoZW4gc2VhcmNoaW5nIGZvcg0KZW5kcG9pbnRzLCBpbiBvcmRlciB0byBhdm9pZCBhIHNlZ2Zh
dWx0IGluIGNhc2UgdGhlIGludGVyZmFjZSBkZXNjcmlwdG9yIGhhcw0KbGVzcyB0aGFuIHR3byBl
bmRwb2ludHMuDQpTaWduZWQtb2ZmLWJ5OiBBbmlydWRoIEJhZ2RlIDxhYmFnZGUxQGdtYWlsLmNv
bT4NCg0KLS0tIGEvZHJpdmVycy9pbnB1dC9qb3lzdGljay9pZm9yY2UvaWZvcmNlLXVzYi5jCTIw
MTYtMDctMjkgMTU6MDI6NDcuNjAyNjMwNTA0IC0wNDAwDQorKysgYi9kcml2ZXJzL2lucHV0L2pv
eXN0aWNrL2lmb3JjZS9pZm9yY2UtdXNiLmMJMjAxNi0wNy0yOSAxNTowMjozMi45NDY4MTIzMzYg
LTA0MDANCkBAIC0xMzUsMTIgKzEzNSwyMyBAQA0KIHsNCiAJc3RydWN0IHVzYl9kZXZpY2UgKmRl
diA9IGludGVyZmFjZV90b191c2JkZXYoaW50Zik7DQogCXN0cnVjdCB1c2JfaG9zdF9pbnRlcmZh
Y2UgKmludGVyZmFjZTsNCi0Jc3RydWN0IHVzYl9lbmRwb2ludF9kZXNjcmlwdG9yICplcGlycSwg
KmVwb3V0Ow0KKwlzdHJ1Y3QgdXNiX2VuZHBvaW50X2Rlc2NyaXB0b3IgKmVwaXJxID0gTlVMTCwg
KmVwb3V0ID0gTlVMTDsNCiAJc3RydWN0IGlmb3JjZSAqaWZvcmNlOw0KLQlpbnQgZXJyID0gLUVO
T01FTTsNCisJaW50IGksIGVyciA9IC1FTk9NRU07DQogDQogCWludGVyZmFjZSA9IGludGYtPmN1
cl9hbHRzZXR0aW5nOw0KIA0KKwlmb3IgKGkgPSAwOyBpIDwgaW50ZXJmYWNlLT5kZXNjLmJOdW1F
bmRwb2ludHM7IGkrKykgew0KKwkJaWYgKCFlcGlycSAmJg0KKwkJICAgIHVzYl9lbmRwb2ludF9k
aXJfaW4oJmludGVyZmFjZS0+ZW5kcG9pbnRbaV0uZGVzYykpDQorCQkJZXBpcnEgPSAmaW50ZXJm
YWNlLT5lbmRwb2ludFtpXS5kZXNjOw0KKwkJaWYgKCFlcG91dCAmJg0KKwkJICAgIHVzYl9lbmRw
b2ludF9kaXJfb3V0KCZpbnRlcmZhY2UtPmVuZHBvaW50W2ldLmRlc2MpKQ0KKwkJCWVwb3V0ID0g
JmludGVyZmFjZS0+ZW5kcG9pbnRbaV0uZGVzYzsNCisJfQ0KKwlpZiAoIWVwaXJxIHx8ICFlcG91
dCkNCisJCXJldHVybiAtRU5PREVWOw0KKw0KIAllcGlycSA9ICZpbnRlcmZhY2UtPmVuZHBvaW50
WzBdLmRlc2M7DQogCWVwb3V0ID0gJmludGVyZmFjZS0+ZW5kcG9pbnRbMV0uZGVzYzs=
--001a1140bcda7317f805390f4883--
