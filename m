From: Robert Munteanu <rombert@apache.org>
Subject: Re: [PATCH 2/2] HID: redragon Add additional verification to rdesc
 modification quirk
Date: Fri, 03 Aug 2018 16:21:56 +0300
Message-ID: <393a529f40e7d61493178a1baeee5e2679c7da11.camel@apache.org>
References: <CAPotdmQtXmfHJfcgrXZ02NrPgS3Az=SpZnBsRZ_8dGvPfdi+Mw@mail.gmail.com>
         <1532807605-26023-1-git-send-email-JohnSGruber@gmail.com>
         <CAPotdmQh_sWqPmiQ=_+fJ27AT7GA5hcne=wsXcmKhNnUpUs3wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPotdmQh_sWqPmiQ=_+fJ27AT7GA5hcne=wsXcmKhNnUpUs3wQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John S Gruber <JohnSGruber@gmail.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 2018-07-28 at 15:53 -0400, John S Gruber wrote:
> There are many devices using the vendor_id 0c45 and device_id of 760b
> combination. Also the two bytes 0x81 0x00 aren't rare for a report
> description. For these reasons the report description being altered
> by the quirk should be verified more completely
> 
> If I'm understanding this correctly, I believe for an array field the
> report_size should be greater or equal to
> ceil(log2(usage_maximum - usage_minimum + 1)). That's 3 bits for
> these 8
> shift keys, 0xe0-0xe7. Therefore the incorrect report description
> can't
> be valid for any device.
> 
> Check the actual count of the rdesc and compare the entire field
> description to reduce the chance of patching the wrong thing by
> inadvertence.
> 
> Signed-off-by: John S Gruber <JohnSGruber@gmail.com>

I tested this on 4.17.11 with 85455dd906d5 and cbe7e3ad0eab from Jiri's
for-4.19/upstream tree and it works just fine.

Feel free to add

  Acked-By: Robert Munteanu <rombert@apache.org>

Thanks for looking into this.

Robert
