From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: new version of usbhid autosuspend patch
Date: Thu, 27 Sep 2007 11:31:35 -0400
Message-ID: <d120d5000709270831y548b0255m2e73572b8a68747b@mail.gmail.com>
References: <200709271633.35098.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200709271633.35098.oliver@neukum.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz, Pavel Machek <pavel@ucw.cz>
List-Id: linux-input@vger.kernel.org

Hi Oliver,

On 9/27/07, Oliver Neukum <oliver@neukum.org> wrote:
> +int hid_check_keys_pressed(struct hid_device *hid)
> +{
> +       struct hid_input *hidinput, *next;
> +       int i;
> +
> +       list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
> +               for (i = 0; i < NBITS(KEY_MAX); i++)
> +                       if (hidinput->input->key[i])
> +                               return 1;
> +       }

Why are you using the list_for_each_entry_safe? You do not alter the
list in your loop.

-- 
Dmitry
