From: Oliver Neukum <oneukum@suse.de>
Subject: possible missing error handling in hidraw
Date: Wed, 25 Apr 2012 15:12:16 +0200
Message-ID: <201204251512.16482.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54786 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325Ab2DYNQS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Apr 2012 09:16:18 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 668EF90072
	for <linux-input@vger.kernel.org>; Wed, 25 Apr 2012 15:16:17 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Hi,

what happens if kmemdup here cannot allocate memory?

	Regards
		Oliver

void hidraw_report_event(struct hid_device *hid, u8 *data, int len)
{
        struct hidraw *dev =3D hid->hidraw;
        struct hidraw_list *list;

        list_for_each_entry(list, &dev->list, node) {
                list->buffer[list->head].value =3D kmemdup(data, len, G=
=46P_ATOMIC);
                list->buffer[list->head].len =3D len;
                list->head =3D (list->head + 1) & (HIDRAW_BUFFER_SIZE -=
 1);
                kill_fasync(&list->fasync, SIGIO, POLL_IN);
        }

        wake_up_interruptible(&dev->wait);
}
EXPORT_SYMBOL_GPL(hidraw_report_event);

--=20
- - -=20
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6=
rffer, HRB 16746 (AG N=FCrnberg)=20
Maxfeldstra=DFe 5                        =20
90409 N=FCrnberg=20
Germany=20
- - -=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
