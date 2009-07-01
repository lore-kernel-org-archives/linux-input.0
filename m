From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH 2/2] Add a driver for the Winbond WPCD376I IR
 functionality.
Date: Wed, 1 Jul 2009 23:45:15 +0200
Message-ID: <20090701214515.GA5946@hardeman.nu>
References: <1246079912-17619-1-git-send-email-david@hardeman.nu>
 <1246079912-17619-3-git-send-email-david@hardeman.nu>
 <20090630142345.58e97b50.akpm@linux-foundation.org>
 <35c700707581a42af21dd9edc82a5e84.squirrel@www.hardeman.nu>
 <20090701110616.60c05a5d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090701110616.60c05a5d.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 01, 2009 at 11:06:16AM -0700, Andrew Morton wrote:
>On Wed, 1 Jul 2009 09:47:46 +0200 (CEST)
>David H=E4rdeman <david@hardeman.nu> wrote:
>>> Something has gone wrong with the types here.  Where does the fault=
 lie
>>> - this driver, or input core?
>>
>> Two issues:
>>
>> a) the input layer API confused me
>> ...
>> b) 32 bit scancodes
>> ...
>
>erp.  Hopefully this is all something which Dmitry can help us with.

I'll wait for feedback from Bjorn Helgaas and Dmitry, meanwhile I've=20
updated the patch to (hopefully) fix all the other issues you've raised=
,=20
I'll send it in a separate mail.

--=20
David H=E4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
