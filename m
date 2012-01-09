From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [RFC PATCH 1/11] input: RMI4 public header file and documentation.
Date: Mon, 9 Jan 2012 12:31:19 -0800
Message-ID: <4F0B4E97.4000107@synaptics.com>
References: <1324519802-23894-1-git-send-email-cheiny@synaptics.com> <1324519802-23894-2-git-send-email-cheiny@synaptics.com> <20120106063546.GA10447@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120106063546.GA10447@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
List-Id: linux-input@vger.kernel.org

On 01/05/2012 10:35 PM, Dmitry Torokhov wrote:
> On Wed, Dec 21, 2011 at 06:09:52PM -0800, Christopher Heiny wrote:
>> +
>> +/* Helper fn to convert a byte array representing a short in the RMI
>> + * endian-ness to a short in the native processor's specific endianness.
>> + * We don't use ntohs/htons here because, well, we're not dealing with
>> + * a pair of shorts. And casting dest to short* wouldn't work, because
>> + * that would imply knowing the byte order of short in the first place.
>> + */
>> +static inline void batohs(unsigned short *dest, unsigned char *src)
>> +{
>> +	*dest = src[1] * 0x100 + src[0];
>> +}
>> +
>> +/* Helper function to convert a short (in host processor endianess) to
>> + * a byte array in the RMI endianess for shorts.  See above comment for
>> + * why we dont us htons or something like that.
>> + */
>> +static inline void hstoba(unsigned char *dest, unsigned short src)
>> +{
>> +	dest[0] = src % 0x100;
>> +	dest[1] = src / 0x100;
>> +}
>
> We have nice set of be/le16_to_cpu and cpu_to_be/le16 helpers that do
> just that and in much more efficient way.

Yay!  We'll switch to those.

>
>> +
>> +/* Utility routine to handle writes to read-only attributes.  Hopefully
>> + * this will never happen, but if the user does something stupid, we don't
>> + * want to accept it quietly (which is what can happen if you just put NULL
>> + * for the attribute's store function).
>> + */
>> +static inline ssize_t rmi_store_error(struct device *dev,
>> +			struct device_attribute *attr,
>> +			const char *buf, size_t count)
>> +{
>> +	dev_warn(dev,
>> +		 "RMI4 WARNING: Attempt to write %d characters to read-only "
>> +		 "attribute %s.", count, attr->attr.name);
>> +	return -EPERM;
>> +}
>> +
>> +/* Utility routine to handle reads of write-only attributes.  Hopefully
>> + * this will never happen, but if the user does something stupid, we don't
>> + * want to accept it quietly (which is what can happen if you just put NULL
>> + * for the attribute's show function).
>> + */
>> +static inline ssize_t rmi_show_error(struct device *dev,
>> +		       struct device_attribute *attr,
>> +		       char *buf)
>> +{
>> +	dev_warn(dev,
>> +		 "RMI4 WARNING: Attempt to read from write-only attribute %s.",
>> +		 attr->attr.name);
>> +	return -EPERM;
>> +}
>
> Although these methods are not needed, a general comment nonetheless: do
> not put in header files and mark inline functions which address is taken
> and used elsewhere.

OK.
