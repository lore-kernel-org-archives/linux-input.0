From: "Justin Mattock" <justinmattock-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: several messages
Date: Sun, 19 Oct 2008 13:06:12 -0700
Message-ID: <dd18b0c30810191306t795dbbabq64645d903568c3c9@mail.gmail.com>
References: <1224425749-22652-1-git-send-email-jirislaby@gmail.com>
	 <1224425749-22652-2-git-send-email-jirislaby@gmail.com>
	 <alpine.LNX.1.10.0810192135010.27479@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.1.10.0810192135010.27479-YCXOAqNspd+N3ZZ/Hiejyg@public.gmane.org>
Content-Disposition: inline
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Steven Noonan <steven-Cunn4gMjHvbm+q05EWxUEA@public.gmane.org>, Sven Anders <anders-3bOZC6EutKuELgA04lAiVw@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Oct 19, 2008 at 12:40 PM, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org> wrote:
> On Sun, 19 Oct 2008, Jiri Slaby wrote:
>
>> +enum hid_type {
>> +     HID_TYPE_UNKNOWN = 0,
>> +     HID_TYPE_MOUSE,
>> +     HID_TYPE_KEYBOARD
>> +};
>> +
>
> Do we really need the HID_TYPE_KEYBOARD at all? It's not used anywhere in
> the code. I'd propose to add it when it is actually needed. I.e. have the
> enum contain something like HID_TYPE_MOUSE HID_TYPE_OTHER for now, and add
> whatever will become necessary in the future, what do you think?
>
>
> On Sun, 19 Oct 2008, Jiri Slaby wrote:
>
>> +/**
>> + * hid_mouse_ignore_list - mouse devices which must not be held by the hid layer
>> + */
>
> I think a more descriptive comment would be appropriate here. It might not
> be obvious on the first sight why this needs to be done separately from
> the generic hid_blacklist. I.e. something like
>
> /**
>  * There are composite devices for which we want to ignore only a certain
>  * interface. This is a list of devices for which only the mouse interface
>  * will be ignored.
>  */
>
> maybe?
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

I can agree with that, whats the point having something
there if it not being used,(just eating up precious space);

-- 
Justin P. Mattock
