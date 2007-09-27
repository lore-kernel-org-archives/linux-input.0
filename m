From: Oliver Neukum <oliver@neukum.org>
Subject: Re: new version of usbhid autosuspend patch
Date: Thu, 27 Sep 2007 20:09:19 +0200
Message-ID: <200709272009.20051.oliver@neukum.org>
References: <200709271633.35098.oliver@neukum.org> <d120d5000709270831y548b0255m2e73572b8a68747b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000709270831y548b0255m2e73572b8a68747b@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz, Pavel Machek <pavel@ucw.cz>
List-Id: linux-input@vger.kernel.org

Am Donnerstag 27 September 2007 schrieb Dmitry Torokhov:
> Hi Oliver,
> 
> On 9/27/07, Oliver Neukum <oliver@neukum.org> wrote:
> > +int hid_check_keys_pressed(struct hid_device *hid)
> > +{
> > +       struct hid_input *hidinput, *next;
> > +       int i;
> > +
> > +       list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
> > +               for (i = 0; i < NBITS(KEY_MAX); i++)
> > +                       if (hidinput->input->key[i])
> > +                               return 1;
> > +       }
> 
> Why are you using the list_for_each_entry_safe? You do not alter the
> list in your loop.

Relict from an older version. I am preparing a new patch.

	Thanks
		Oliver
